import QtCore
import QtQuick
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

// When Prayer Times: DankMaterialShell widget for the `when` CLI.
//
// Source of truth: the `when` CLI, never the system date.
//   * `when next --json`  -> next prayer + `remaining` (computed by `when`)
//   * `when all --json`   -> ordered list of the day's prayers
// The countdown is anchored to the `remaining` value `when` reports and ticked
// locally with a plain counter. The current period and the progress bar are
// derived from the ORDER of `when all` and the next prayer `when` reports.
// Nothing here reads the system date or compares prayer times against the
// system clock.
PluginComponent {
    id: root

    pluginId: "whenPrayer"
    popoutWidth: 380

    // ───────────────────────── Settings ─────────────────────────
    readonly property string whenBin: {
        var p = pluginData.whenPath;
        return (p && String(p).trim() !== "") ? String(p).trim() : "when";
    }
    readonly property bool showName: pluginData.showName ?? true
    readonly property bool showTime: pluginData.showTime ?? true
    readonly property bool showCountdown: pluginData.showCountdown ?? true
    readonly property bool showCurrentPeriod: pluginData.showCurrentPeriod ?? false
    readonly property bool showSeconds: pluginData.showSeconds ?? false
    readonly property bool use12H: pluginData.use12H ?? false
    readonly property bool showIcon: pluginData.showIcon ?? true
    readonly property bool showPopupCountdown: pluginData.showPopupCountdown ?? false
    readonly property bool showProgressBar: pluginData.showProgressBar ?? false
    readonly property bool showProgressRing: pluginData.showProgressRing ?? false

    // ───────────────────────── State (all from `when`) ─────────────────────────
    property var prayers: []              // [{name, time}] in the order `when all` returns
    property string nextName: ""
    property string nextTime: ""
    property int remainingSec: 0          // anchored to `when next`, ticked by a counter
    property bool hasData: false
    property string errorText: ""
    property bool alarmRunning: false
    property bool alarmBusy: false
    property string dateLabel: ""         // from the when cache (prayer-times.json)
    property string hijriLabel: ""

    // tick bookkeeping (monotonic deltas only, no calendar date involved)
    property double lastTickMs: 0
    property double lastRollMs: 0

    // ───────────────────────── Derived ─────────────────────────
    function findIndex(list, name) {
        var n = String(name).toLowerCase();
        for (var i = 0; i < list.length; i++) {
            if (String(list[i].name).toLowerCase() === n)
                return i;
        }
        return -1;
    }

    function toMin(hhmm) {
        var m = /^(\d{1,2}):(\d{2})/.exec(String(hhmm || ""));
        return m ? parseInt(m[1], 10) * 60 + parseInt(m[2], 10) : 0;
    }

    readonly property int nextIndex: findIndex(prayers, nextName)
    readonly property var currEntry: (prayers.length > 0 && nextIndex >= 0) ? prayers[(nextIndex - 1 + prayers.length) % prayers.length] : null
    readonly property string currName: currEntry ? currEntry.name : ""
    readonly property int periodTotalSec: {
        if (!currEntry || nextIndex < 0)
            return 0;
        var d = toMin(nextTime) - toMin(currEntry.time);
        if (d <= 0)
            d += 1440;
        return d * 60;
    }
    readonly property real progress: periodTotalSec > 0 ? Math.min(1, Math.max(0, 1 - remainingSec / periodTotalSec)) : 0
    readonly property int urgentWindowSec: 15 * 60
    readonly property bool isUrgent: hasData && remainingSec > 0 && remainingSec <= urgentWindowSec

    // Material You 3 palette, mapped onto DMS theme tokens with safe fallbacks
    readonly property color cPrimary: Theme.primary
    readonly property color cOnPrimary: Theme.onPrimary ?? Theme.primaryText ?? Theme.background
    readonly property color cPrimaryContainer: Theme.primaryContainer ?? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.22)
    readonly property color cOnPrimaryContainer: Theme.onPrimaryContainer ?? Theme.surfaceText
    readonly property color cSecContainer: Theme.secondaryContainer ?? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.16)
    readonly property color cSurface1: Theme.surfaceContainer ?? Qt.rgba(Theme.surfaceText.r, Theme.surfaceText.g, Theme.surfaceText.b, 0.06)
    readonly property color cError: Theme.error ?? "#ba1a1a"
    readonly property color cErrorContainer: Theme.errorContainer ?? Qt.rgba(cError.r, cError.g, cError.b, 0.18)

    readonly property string pillText: {
        if (!hasData)
            return errorText !== "" ? "when ?" : "…";
        var parts = [];
        if (showCurrentPeriod && currName !== "")
            parts.push(currName + " →");
        if (showName)
            parts.push(nextName);
        if (showTime)
            parts.push(fmtTime(nextTime));
        if (showCountdown)
            parts.push((showTime ? "· " : "") + fmtCountdown(remainingSec, showSeconds));
        return parts.join(" ");
    }

    readonly property string verticalPillText: {
        if (!hasData)
            return "";
        if (showCountdown)
            return fmtCountdown(remainingSec, showSeconds);
        if (showTime)
            return fmtTime(nextTime);
        if (showName)
            return nextName;
        if (showCurrentPeriod && currName !== "")
            return currName;
        return "";
    }

    // ───────────────────────── Formatting ─────────────────────────
    function pad(n) {
        return (n < 10 ? "0" : "") + n;
    }

    function cap(s) {
        s = String(s || "");
        return s.length ? s.charAt(0).toUpperCase() + s.slice(1) : s;
    }

    function fmtDate(iso) {
        var m = /^(\d{4})-(\d{2})-(\d{2})/.exec(String(iso));
        if (!m)
            return String(iso);
        return Qt.formatDate(new Date(parseInt(m[1], 10), parseInt(m[2], 10) - 1, parseInt(m[3], 10)), "dddd, d MMMM yyyy");
    }

    function fmtTime(t) {
        if (!t)
            return "";
        if (!use12H)
            return t;
        var p = String(t).split(":");
        if (p.length < 2)
            return t;
        var h = parseInt(p[0], 10);
        var ap = h >= 12 ? "PM" : "AM";
        h = h % 12;
        if (h === 0)
            h = 12;
        return h + ":" + p[1].substring(0, 2) + " " + ap;
    }

    function fmtCountdown(sec, withSec) {
        sec = Math.max(0, Math.floor(sec));
        if (withSec) {
            var h = Math.floor(sec / 3600), m = Math.floor((sec % 3600) / 60), s = sec % 60;
            return h > 0 ? h + ":" + pad(m) + ":" + pad(s) : pad(m) + ":" + pad(s);
        }
        var totalMin = Math.ceil(sec / 60);
        var hh = Math.floor(totalMin / 60), mm = totalMin % 60;
        if (hh > 0)
            return hh + "h " + pad(mm) + "m";
        return totalMin > 0 ? totalMin + "m" : "<1m";
    }

    function fmtHMS(sec) {
        sec = Math.max(0, Math.floor(sec));
        return pad(Math.floor(sec / 3600)) + ":" + pad(Math.floor((sec % 3600) / 60)) + ":" + pad(sec % 60);
    }

    // Parses Go durations such as "2h45m0s", "45m0s", "30s", "1m30.5s"
    function parseDuration(v) {
        if (typeof v === "number")
            return Math.max(0, Math.ceil(v));
        if (!v)
            return -1;
        var re = /(\d+(?:\.\d+)?)(ms|µs|us|ns|h|m|s)/g;
        var total = 0, found = false, mt;
        var s = String(v);
        while ((mt = re.exec(s)) !== null) {
            found = true;
            var n = parseFloat(mt[1]);
            switch (mt[2]) {
            case "h": total += n * 3600; break;
            case "m": total += n * 60; break;
            case "s": total += n; break;
            case "ms": total += n / 1000; break;
            default: break;
            }
        }
        return found ? Math.ceil(total) : -1;
    }

    function prayerIcon(name) {
        switch (String(name).toLowerCase()) {
        case "imsak": return "nightlight";
        case "fajr": return "partly_cloudy_night";
        case "shorouq":
        case "sunrise": return "wb_twilight";
        case "dhuhr": return "wb_sunny";
        case "asr": return "light_mode";
        case "maghrib": return "wb_twilight";
        case "isha": return "dark_mode";
        case "midnight": return "bedtime";
        default: return "mosque";
        }
    }

    // ───────────────────────── `when` CLI plumbing ─────────────────────────
    function refreshNext() {
        if (!nextProc.running)
            nextProc.running = true;
    }

    function refreshAll() {
        if (!allProc.running)
            allProc.running = true;
    }

    // Refresh button: refetch prayer data AND re-sync the alarm switch with
    // the real `when alarm` process (killed or started from outside the widget).
    function forceRefresh() {
        if (!refreshProc.running)
            refreshProc.running = true;
        checkAlarm();
    }

    function checkAlarm() {
        if (!alarmCheckProc.running)
            alarmCheckProc.running = true;
    }

    function fail(msg) {
        errorText = msg;
    }

    function handleNext(text) {
        var t = (text || "").trim();
        if (t === "") {
            fail("No output from `" + whenBin + " next --json`. Is `when` installed and reachable? Set its full path in the plugin settings.");
            return;
        }
        var obj;
        try {
            obj = JSON.parse(t);
        } catch (e) {
            fail("Could not parse `when next --json`: " + t.substring(0, 80));
            return;
        }
        if (Array.isArray(obj))
            obj = obj[0] || {};
        var name = cap(obj.name || obj.Name || "");
        var time = obj.time || obj.Time || "";
        var rem = parseDuration(obj.remaining !== undefined ? obj.remaining : obj.Remaining);
        if (name === "" || rem < 0) {
            fail("Unexpected output from `when next --json`.");
            return;
        }
        var changed = (name !== nextName || time !== nextTime);
        nextName = name;
        nextTime = time;
        remainingSec = rem;
        errorText = "";
        hasData = true;
        // A new prayer means a new period (and after Midnight, a new day): reload the list.
        if (changed || prayers.length === 0)
            refreshAll();
    }

    function handleAll(text) {
        var t = (text || "").trim();
        if (t === "")
            return;
        var json;
        try {
            json = JSON.parse(t);
        } catch (e) {
            return;
        }
        var arr = Array.isArray(json) ? json : (json.prayers || json.times || json.data || null);
        if (!arr && json && typeof json === "object") {
            arr = [];
            for (var k in json) {
                if (typeof json[k] === "string" && /^\d{1,2}:\d{2}/.test(json[k]))
                    arr.push({
                        name: k,
                        time: json[k]
                    });
            }
        }
        if (!arr || arr.length === 0)
            return;
        var out = [];
        for (var i = 0; i < arr.length; i++) {
            var e = arr[i];
            var n = cap(e.name || e.Name || e.prayer || "");
            var tm = e.time || e.Time || "";
            if (n !== "" && tm !== "")
                out.push({
                    name: n,
                    time: String(tm)
                });
        }
        if (out.length === 0)
            return;
        prayers = out;
        if (!Array.isArray(json)) {
            var d = json.date || json.gregorian || "";
            if (d !== "")
                dateLabel = fmtDate(String(d));
            var h = json.hijri || "";
            if (h !== "")
                hijriLabel = String(h);
        }
        if (nextTime === "" && nextIndex >= 0)
            nextTime = out[nextIndex].time;
    }

    // `when all --json` only returns the prayer array. The date lives in the
    // cache file, so read it from there.
    function handleCache(text) {
        var t = (text || "").trim();
        if (t === "")
            return;
        var obj;
        try {
            obj = JSON.parse(t);
        } catch (e) {
            return;
        }
        var d = obj.date || obj.Date || obj.gregorian || "";
        if (d !== "")
            dateLabel = fmtDate(String(d));
        var h = obj.hijri || obj.Hijri || "";
        if (h !== "")
            hijriLabel = String(h);
    }

    Process {
        id: nextProc
        command: [root.whenBin, "next", "--json"]
        stdout: StdioCollector {
            onStreamFinished: root.handleNext(text)
        }
    }

    Process {
        id: allProc
        command: [root.whenBin, "all", "--json"]
        stdout: StdioCollector {
            onStreamFinished: root.handleAll(text)
        }
    }

    // `when refresh` forces a refetch from Al-Manar and updates the cache
    Process {
        id: refreshProc
        command: [root.whenBin, "refresh", "--json"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.handleAll(text);
                root.refreshNext();
                cacheFile.reload();
            }
        }
    }

    // Watch the `when` cache for the date (and hi-jri date, if present)
    FileView {
        id: cacheFile
        path: StandardPaths.writableLocation(StandardPaths.GenericCacheLocation) + "/when/prayer-times.json"
        blockLoading: true
        blockWrites: true
        watchChanges: true
        onLoaded: root.handleCache(cacheFile.text())
        onLoadFailed: error => {}
    }

    // Detects `when alarm` whether started by this widget, a terminal or systemd
    Process {
        id: alarmCheckProc
        command: ["pgrep", "-f", "(^|/)when alarm"]
        onExited: (exitCode, exitStatus) => {
            root.alarmRunning = (exitCode === 0);
            root.alarmBusy = false;
        }
    }

    function toggleAlarm() {
        if (alarmBusy)
            return;
        alarmBusy = true;
        if (alarmRunning)
            Quickshell.execDetached(["pkill", "-f", "(^|/)when alarm"]);
        else
            Quickshell.execDetached([whenBin, "alarm", "--daemon"]);
        alarmRecheck.restart();
    }

    Timer {
        id: alarmRecheck
        interval: 900
        onTriggered: root.checkAlarm()
    }

    // ───────────────────────── Clock tick (counter, not a calendar) ─────────────────────────
    Timer {
        id: tickTimer
        interval: 1000
        repeat: true
        running: true
        onTriggered: root.tick()
    }

    function tick() {
        var now = Date.now();
        var gap = now - lastTickMs;
        lastTickMs = now;
        // Long gap = suspend/resume or clock jump: re-ask `when` instead of trusting the counter.
        if (lastTickMs > 0 && gap > 3500)
            refreshNext();
        if (!hasData)
            return;

        if (remainingSec > 0)
            remainingSec -= 1;

        if (remainingSec <= 0) {
            // Ask `when` what comes next (retry every 2s until it moves on)
            if (now - lastRollMs > 2000) {
                lastRollMs = now;
                refreshNext();
            }
        }
    }

    // Keep the azan-daemon state in sync. This does not query `when`; prayer
    // data is only refreshed manually or at a prayer transition.
    Timer {
        interval: 30000
        repeat: true
        running: true
        onTriggered: root.checkAlarm()
    }

    Component.onCompleted: {
        lastTickMs = Date.now();
        refreshNext();
        checkAlarm();
    }

    // ───────────────────────── Material You 3 building blocks ─────────────────────────
    component M3IconButton: Item {
        id: btn
        property string icon: ""
        property bool filled: false      // filled-tonal style
        property bool spinning: false
        signal clicked

        width: 40
        height: 40

        readonly property color tonalBg: Theme.secondaryContainer ?? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.16)
        readonly property color fg: filled ? (Theme.onSecondaryContainer ?? Theme.surfaceText) : Theme.surfaceVariantText

        Rectangle {
            anchors.fill: parent
            radius: height / 2
            color: btn.filled ? btn.tonalBg : "transparent"
            Behavior on color {
                ColorAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
        }
        // state layer: 8% hover, 12% pressed
        Rectangle {
            anchors.fill: parent
            radius: height / 2
            color: btn.fg
            opacity: ma.pressed ? 0.12 : (ma.containsMouse ? 0.08 : 0)
            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }
        }
        DankIcon {
            id: ic
            anchors.centerIn: parent
            name: btn.icon
            size: 20
            color: btn.fg
            NumberAnimation on rotation {
                running: btn.spinning
                from: 0
                to: 360
                duration: 900
                loops: Animation.Infinite
                onRunningChanged: if (!running)
                    ic.rotation = 0
            }
        }
        MouseArea {
            id: ma
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: btn.clicked()
        }
    }

    component M3Switch: Item {
        id: sw
        property bool checked: false
        property bool enabledState: true
        signal toggled

        width: 52
        height: 32
        opacity: enabledState ? 1 : 0.5

        Rectangle {
            anchors.fill: parent
            radius: height / 2
            color: sw.checked ? Theme.primary : (Theme.surfaceContainerHighest ?? Theme.surfaceVariant)
            border.width: sw.checked ? 0 : 2
            border.color: Theme.outline ?? Theme.surfaceVariantText
            Behavior on color {
                ColorAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
        }
        Rectangle {
            id: thumb
            property int size: swMa.pressed ? 28 : (sw.checked ? 24 : 16)
            width: size
            height: size
            radius: size / 2
            anchors.verticalCenter: parent.verticalCenter
            x: sw.checked ? parent.width - width - 4 : (swMa.pressed ? 2 : 8)
            color: sw.checked ? (Theme.onPrimary ?? Theme.background) : (Theme.outline ?? Theme.surfaceVariantText)
            Behavior on x {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on size {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on color {
                ColorAnimation {
                    duration: 200
                }
            }
        }
        MouseArea {
            id: swMa
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            enabled: sw.enabledState
            onClicked: sw.toggled()
        }
    }

    // ───────────────────────── Bar pills ─────────────────────────
    horizontalBarPill: Component {
        Row {
            spacing: root.pillText !== "" ? Theme.spacingXS : 0

            DankIcon {
                visible: root.showIcon
                name: "mosque"
                size: Theme.iconSize - 10
                color: root.errorText !== "" && !root.hasData ? root.cError : Theme.surfaceText
                anchors.verticalCenter: parent.verticalCenter
            }
            StyledText {
                visible: root.pillText !== ""
                text: root.pillText
                font.pixelSize: Theme.fontSizeSmall
                font.weight: root.isUrgent ? Font.Bold : Font.Normal
                color: root.isUrgent ? root.cPrimary : Theme.surfaceText
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    verticalBarPill: Component {
        Column {
            spacing: 2

            DankIcon {
                visible: root.showIcon
                name: "mosque"
                size: Theme.iconSize - 6
                color: root.errorText !== "" && !root.hasData ? root.cError : root.cPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }
            StyledText {
                visible: root.verticalPillText !== ""
                text: root.verticalPillText
                font.pixelSize: Theme.fontSizeSmall - 2
                color: root.isUrgent ? root.cPrimary : Theme.surfaceText
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    // ───────────────────────── Popout ─────────────────────────
    popoutContent: Component {
        Item {
            id: pop
            width: 380
            implicitWidth: 380
            implicitHeight: content.implicitHeight + 24

            // While the popout is open: sync the alarm switch on open and every 3 s,
            // so killing or starting `when alarm` elsewhere is reflected right away.
            Component.onCompleted: root.checkAlarm()
            Timer {
                interval: 3000
                repeat: true
                running: true
                onTriggered: root.checkAlarm()
            }

            Column {
                id: content
                x: 12
                y: 12
                width: parent.width - 24
                spacing: 12

                // ── Header ──
                Item {
                    width: parent.width
                    height: 44

                    Row {
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 12

                        DankIcon {
                            name: "mosque"
                            size: 26
                            color: root.cPrimary
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 1
                            StyledText {
                                text: "Prayer times"
                                font.pixelSize: Theme.fontSizeLarge
                                font.weight: Font.Bold
                                color: Theme.surfaceText
                            }
                            StyledText {
                                visible: text !== ""
                                text: root.hijriLabel !== "" ? (root.hijriLabel + (root.dateLabel !== "" ? " · " + root.dateLabel : "")) : root.dateLabel
                                font.pixelSize: Theme.fontSizeSmall
                                color: Theme.surfaceVariantText
                            }
                        }
                    }

                    M3IconButton {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        icon: "refresh"
                        spinning: refreshProc.running || alarmCheckProc.running
                        onClicked: root.forceRefresh()
                    }
                }

                // ── Error card ──
                Rectangle {
                    visible: root.errorText !== ""
                    width: parent.width
                    height: errRow.implicitHeight + 24
                    radius: 20
                    color: root.cErrorContainer

                    Row {
                        id: errRow
                        x: 16
                        y: 12
                        width: parent.width - 32
                        spacing: 12
                        DankIcon {
                            name: "error_outline"
                            size: 22
                            color: root.cError
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        StyledText {
                            width: parent.width - 34
                            text: root.errorText + (root.hasData ? "\nShowing last known data." : "")
                            wrapMode: Text.WordWrap
                            font.pixelSize: Theme.fontSizeSmall
                            color: Theme.surfaceText
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                // ── Hero: next prayer ──
                Rectangle {
                    visible: root.hasData
                    width: parent.width
                    height: heroCol.implicitHeight + 40
                    radius: 28
                    color: root.cPrimaryContainer

                    Column {
                        id: heroCol
                        x: 20
                        y: 20
                        width: parent.width - 40
                        spacing: 10

                        Item {
                            width: parent.width
                            height: 60

                            Row {
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 12

                                Item {
                                    id: ring
                                    width: 60
                                    height: 60
                                    anchors.verticalCenter: parent.verticalCenter

                                    property real shown: root.progress
                                    Behavior on shown {
                                        NumberAnimation {
                                            duration: 900
                                            easing.type: Easing.OutCubic
                                        }
                                    }
                                    onShownChanged: ringCanvas.requestPaint()

                                    Canvas {
                                        id: ringCanvas
                                        anchors.fill: parent
                                        visible: root.showProgressRing
                                        property color ringColor: root.cPrimary
                                        property color trackColor: Theme.withAlpha(root.cOnPrimaryContainer, 0.16)

                                        antialiasing: true
                                        Component.onCompleted: requestPaint()
                                        onRingColorChanged: requestPaint()
                                        onTrackColorChanged: requestPaint()
                                        onWidthChanged: requestPaint()
                                        onHeightChanged: requestPaint()

                                        onPaint: {
                                            var ctx = getContext("2d");
                                            ctx.reset();
                                            ctx.clearRect(0, 0, width, height);
                                            var cx = width / 2;
                                            var cy = height / 2;
                                            var lw = 7;
                                            var r = (Math.min(width, height) - lw) / 2;
                                            ctx.lineWidth = lw;
                                            ctx.lineCap = "round";
                                            ctx.beginPath();
                                            ctx.arc(cx, cy, r, 0, Math.PI * 2);
                                            ctx.strokeStyle = trackColor;
                                            ctx.stroke();
                                            var p = Math.max(0, Math.min(1, ring.shown));
                                            if (p > 0.005) {
                                                ctx.beginPath();
                                                ctx.arc(cx, cy, r, -Math.PI / 2, -Math.PI / 2 + Math.PI * 2 * p);
                                                ctx.strokeStyle = ringColor;
                                                ctx.stroke();
                                            }
                                        }
                                    }

                                    Rectangle {
                                        anchors.centerIn: parent
                                        width: 44
                                        height: 44
                                        radius: 22
                                        color: root.showProgressRing ? "transparent" : root.cPrimary
                                        DankIcon {
                                            anchors.centerIn: parent
                                            name: root.prayerIcon(root.nextName)
                                            size: 24
                                            color: root.showProgressRing ? root.cPrimary : root.cOnPrimary
                                        }
                                    }
                                }
                                Column {
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 1
                                    StyledText {
                                        text: "Next prayer"
                                        font.pixelSize: Theme.fontSizeSmall
                                        color: root.cOnPrimaryContainer
                                        opacity: 0.75
                                    }
                                    StyledText {
                                        text: root.nextName
                                        font.pixelSize: Theme.fontSizeLarge + 2
                                        font.weight: Font.Bold
                                        color: root.cOnPrimaryContainer
                                    }
                                }
                            }

                            Rectangle {
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                width: atText.implicitWidth + 24
                                height: 32
                                radius: 16
                                color: Qt.rgba(root.cOnPrimaryContainer.r, root.cOnPrimaryContainer.g, root.cOnPrimaryContainer.b, 0.12)
                                StyledText {
                                    id: atText
                                    anchors.centerIn: parent
                                    text: root.fmtTime(root.nextTime)
                                    font.pixelSize: Theme.fontSizeMedium
                                    font.weight: Font.Bold
                                    color: root.cOnPrimaryContainer
                                }
                            }
                        }

                        StyledText {
                            visible: root.showPopupCountdown
                            text: root.fmtHMS(root.remainingSec)
                            font.pixelSize: 44
                            font.weight: Font.Bold
                            color: root.cOnPrimaryContainer
                        }

                        // M3 linear progress indicator: elapsed share of the current period
                        Item {
                            visible: root.showProgressBar
                            width: parent.width
                            height: 8
                            Rectangle {
                                anchors.fill: parent
                                radius: 4
                                color: Qt.rgba(root.cOnPrimaryContainer.r, root.cOnPrimaryContainer.g, root.cOnPrimaryContainer.b, 0.16)
                            }
                            Rectangle {
                                height: parent.height
                                width: Math.max(height, parent.width * root.progress)
                                radius: 4
                                color: root.cPrimary
                                Behavior on width {
                                    NumberAnimation {
                                        duration: 900
                                        easing.type: Easing.OutCubic
                                    }
                                }
                            }
                        }
                    }
                }

                // ── Prayer list ──
                Rectangle {
                    visible: root.prayers.length > 0
                    width: parent.width
                    height: listCol.implicitHeight + 16
                    radius: 24
                    color: root.cSurface1

                    Column {
                        id: listCol
                        x: 8
                        y: 8
                        width: parent.width - 16
                        spacing: 2

                        Repeater {
                            model: root.prayers
                            delegate: Item {
                                id: row
                                width: listCol.width
                                height: 48

                                readonly property bool isNext: index === root.nextIndex
                                readonly property color fg: isNext ? (Theme.onSecondaryContainer ?? Theme.surfaceText) : Theme.surfaceText

                                Rectangle {
                                    anchors.fill: parent
                                    radius: 24
                                    color: row.isNext ? root.cSecContainer : "transparent"
                                    Behavior on color {
                                        ColorAnimation {
                                            duration: 250
                                            easing.type: Easing.OutCubic
                                        }
                                    }
                                }
                                Rectangle {
                                    anchors.fill: parent
                                    radius: 24
                                    color: row.fg
                                    opacity: rowMa.containsMouse ? 0.08 : 0
                                }

                                Row {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 16
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 14

                                    DankIcon {
                                        name: root.prayerIcon(modelData.name)
                                        size: 22
                                        color: row.isNext ? root.cPrimary : row.fg
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                    StyledText {
                                        text: modelData.name
                                        width: 110
                                        font.pixelSize: Theme.fontSizeMedium
                                        font.weight: row.isNext ? Font.Bold : Font.Normal
                                        color: row.fg
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                StyledText {
                                    anchors.right: parent.right
                                    anchors.rightMargin: 18
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: root.fmtTime(modelData.time)
                                    font.pixelSize: Theme.fontSizeMedium
                                    font.weight: row.isNext ? Font.Bold : Font.Normal
                                    color: row.fg
                                }

                                MouseArea {
                                    id: rowMa
                                    anchors.fill: parent
                                    hoverEnabled: true
                                }
                            }
                        }
                    }
                }

                // ── Alarm daemon card ──
                Rectangle {
                    width: parent.width
                    height: 72
                    radius: 24
                    color: root.cSurface1

                    Row {
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 14

                        Rectangle {
                            width: 40
                            height: 40
                            radius: 20
                            anchors.verticalCenter: parent.verticalCenter
                            color: root.alarmRunning ? Qt.rgba(root.cPrimary.r, root.cPrimary.g, root.cPrimary.b, 0.16) : Qt.rgba(Theme.surfaceText.r, Theme.surfaceText.g, Theme.surfaceText.b, 0.08)
                            Behavior on color {
                                ColorAnimation {
                                    duration: 200
                                }
                            }
                            DankIcon {
                                anchors.centerIn: parent
                                name: root.alarmRunning ? "notifications_active" : "notifications_off"
                                size: 22
                                color: root.alarmRunning ? root.cPrimary : Theme.surfaceVariantText
                            }
                        }
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 1
                            StyledText {
                                text: "Azan alarm"
                                font.pixelSize: Theme.fontSizeMedium
                                font.weight: Font.Medium
                                color: Theme.surfaceText
                            }
                            StyledText {
                                text: root.alarmRunning ? "when alarm is running" : "Stopped"
                                font.pixelSize: Theme.fontSizeSmall
                                color: Theme.surfaceVariantText
                            }
                        }
                    }

                    M3Switch {
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        checked: root.alarmRunning
                        enabledState: !root.alarmBusy
                        onToggled: root.toggleAlarm()
                    }
                }

                // ── Footer ──
                StyledText {
                    width: parent.width
                    visible: !root.hasData
                    horizontalAlignment: Text.AlignHCenter
                    text: "Waiting for when…"
                    font.pixelSize: Theme.fontSizeSmall - 1
                    color: Theme.surfaceVariantText
                    opacity: 0.8
                }
            }
        }
    }
}

import QtQuick
import qs.Common
import qs.Widgets
import qs.Modules.Plugins

PluginSettings {
    id: root
    pluginId: "whenPrayer"

    StyledText {
        width: parent.width
        text: "When Prayer Times"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    StyledText {
        width: parent.width
        text: "Reads everything from the `when` CLI, including the next prayer and the remaining time. The system date is never used."
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
        wrapMode: Text.WordWrap
    }

    // ── Bar pill (same toggles as the COSMIC applet) ──
    StyledText {
        width: parent.width
        text: "Bar"
        font.pixelSize: Theme.fontSizeMedium
        font.weight: Font.Bold
        color: Theme.primary
        topPadding: Theme.spacingM
    }

    ToggleSetting {
        settingKey: "showName"
        label: "Show prayer name"
        description: "Display the next prayer name in the bar"
        defaultValue: true
    }

    ToggleSetting {
        settingKey: "showTime"
        label: "Show prayer time"
        description: "Display the next prayer's time in the bar"
        defaultValue: true
    }

    ToggleSetting {
        settingKey: "showCountdown"
        label: "Show countdown"
        description: "Display the live countdown to the next prayer"
        defaultValue: true
    }

    ToggleSetting {
        settingKey: "showCurrentPeriod"
        label: "Show current period"
        description: "Show the current prayer period before the arrow (Asr → Maghrib)"
        defaultValue: false
    }

    ToggleSetting {
        settingKey: "showSeconds"
        label: "Show seconds in the bar countdown"
        defaultValue: false
    }

    ToggleSetting {
        settingKey: "use12H"
        label: "12-hour clock"
        defaultValue: false
    }

    ToggleSetting {
        settingKey: "showIcon"
        label: "Show icon"
        description: "Display the mosque icon in the bar, in the accent color"
        defaultValue: true
    }

    // ── Popout ──
    StyledText {
        width: parent.width
        text: "Popout"
        font.pixelSize: Theme.fontSizeMedium
        font.weight: Font.Bold
        color: Theme.primary
        topPadding: Theme.spacingM
    }

    ToggleSetting {
        settingKey: "showPopupCountdown"
        label: "Show countdown"
        description: "Show the remaining time as HH:MM:SS in the next-prayer card"
        defaultValue: false
    }

    ToggleSetting {
        settingKey: "showProgressBar"
        label: "Show progress bar"
        description: "Show the current prayer period progress in the next-prayer card"
        defaultValue: false
    }

    ToggleSetting {
        settingKey: "showProgressRing"
        label: "Show progress ring"
        description: "Draw the current prayer period progress as a ring around the next-prayer icon"
        defaultValue: false
    }

    // ── CLI ──
    StyledText {
        width: parent.width
        text: "when CLI"
        font.pixelSize: Theme.fontSizeMedium
        font.weight: Font.Bold
        color: Theme.primary
        topPadding: Theme.spacingM
    }

    StringSetting {
        settingKey: "whenPath"
        label: "Path to `when`"
        description: "Leave empty to use PATH. The shell may not see ~/go/bin, so use an absolute path like /home/you/go/bin/when (no ~)"
        placeholder: "when"
        defaultValue: ""
    }

    StyledText {
        width: parent.width
        text: "Syncs on startup, when you press refresh in the popout, and automatically after each prayer. It does not poll on a timer."
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
        wrapMode: Text.WordWrap
    }
}

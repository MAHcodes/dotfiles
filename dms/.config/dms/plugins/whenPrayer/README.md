# When Prayer Times: DankMaterialShell plugin

> [!WARNING]
> **Disclaimer:** This project was "vibe coded" primarily for personal use that I decided to open-source. It is provided as-is, without any warranties.
>
> **USE AT YOUR OWN RISK**

A DankBar widget for the [`when`](https://github.com/MAHcodes/when) prayer-times CLI
(Al-Manar data). It is the DMS port of `when-cosmic-applet`, with a Material You 3 popout.

## Requirements

- DankMaterialShell on niri (or any Wayland compositor DMS supports)
- `when` installed (`go install github.com/MAHcodes/when@latest`) with `when next --json` working
- `pgrep`/`pkill` for the alarm toggle

## Install

```sh
cp -r whenPrayer ~/.config/DankMaterialShell/plugins/
# DMS Settings → Plugins → Scan for Plugins → enable "When Prayer Times"
# add the widget to DankBar, then:
dms restart
```

Live-reload while editing: `dms ipc call plugins reload whenPrayer`

## Where the date and time come from

Everything comes from `when`. The widget never reads the system date or compares
prayer times with the system clock.

| Thing | Source |
|---|---|
| Next prayer + time | `when next --json` |
| Remaining time | `remaining` field from `when next --json`, ticked by a 1 s counter (no timer polling) |
| Prayer list | `when all --json`, in the order `when` returns |
| Current period | the entry before the next prayer in that list |
| Progress bar | position in that list + `remaining` |
| Force refetch | `when refresh --json` |
| Date shown in the popout | `date` field in the `when` cache (`~/.cache/when/prayer-times.json`) |

`when` is queried on startup, when you press refresh in the popout, and
automatically when a prayer time arrives (which also reloads the list, so day
rollover is picked up). A resume from suspend also triggers a catch-up sync so a
prayer missed while asleep doesn't leave stale data. There is no periodic
re-sync.

## Features

- Bar pill: mosque icon in the accent color (can be hidden), current period → next prayer, time, live countdown (all toggleable, as in the COSMIC applet), 12/24 h, automatic icon-only mode when all text options are off, horizontal and vertical bars
- Popout: next-prayer hero card with time, optional HH:MM:SS countdown, optional period progress ring (thick rounded ring around the prayer icon) and progress bar (all off by default), full prayer list with the next prayer highlighted, manual refresh button (`when refresh`)
- Azan alarm switch: starts `when alarm --daemon`, stops it with `pkill`, and detects a daemon started elsewhere
- Error card with last-known data if `when` fails

## Troubleshooting

- Bar shows `when ?`: DMS can't find the binary. Set the absolute path in the plugin settings (`~` is not expanded).
- Alarm switch snaps back off when you run `when alarm` as a systemd service: stop it with `systemctl --user stop when.service` instead.
- Logs: `dms kill && dms run` from a terminal.

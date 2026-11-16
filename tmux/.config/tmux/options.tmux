# fix colors
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"

# disable bullshit options
set -g mouse off

# enable vim mode
set-window-option -g mode-keys vi

# set prefix to ctrl+`
unbind C-b
set -g prefix C-Space
bind C-Space send-prefix

# base index 1 instaed of 0
set -g base-index 1
setw -g pane-base-index 1

# zero-out escape time delay
set -g escape-time 0

# renumber all windows when any window is closed
set -g renumber-windows on

# clipboard
set -g set-clipboard on

# status-position
set-option -g status-position top

# don't exit tmux when closing a session
set -g detach-on-destroy off

# passthrough
set -g allow-passthrough on

# window title
set-option -g set-titles on
set-option -g set-titles-string '#{b:pane_current_path}'

# extended keys
set -g extended-keys on
set -g extended-keys-format csi-u

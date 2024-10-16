# catppuccin plugin
set -g @plugin "MAHcodes/tmux"

set -g @catppuccin_flavour "mocha"

# catppuccin config
set -g @catppuccin_window_left_separator "█"
set -g @catppuccin_window_right_separator "█"
set -g @catppuccin_window_middle_separator " │ "
set -g @catppuccin_window_number_position "left"

set -g @catppuccin_window_status_enable "yes"
set -g @catppuccin_window_status_icon_enable "no"
set -g @catppuccin_icon_window_last "󰖰"
set -g @catppuccin_icon_window_current "󰖯"
set -g @catppuccin_icon_window_zoom "󰁌"
set -g @catppuccin_icon_window_mark "󰃀"
set -g @catppuccin_icon_window_silent "󰂛"
set -g @catppuccin_icon_window_activity "󰖲"
set -g @catppuccin_icon_window_bell "󰂞"

set -g @catppuccin_window_default_fill "none"
set -g @catppuccin_window_current_fill "all"

set -g @catppuccin_window_default_text "#W"
set -g @catppuccin_window_current_text "#{b:pane_current_path}"
set -g @catppuccin_window_current_format_directory_text "#{b:pane_current_path}"

set -g @catppuccin_status_left_separator " █"
set -g @catppuccin_status_right_separator "█"
set -g @catppuccin_status_right_separator_inverse "yes"
set -g @catppuccin_status_connect_separator "yes"
set -g @catppuccin_status_fill "icon"
set -g @catppuccin_status_modules_right "session gitmux"

set -g @catppuccin_gitmux_icon " "
set -g @catppuccin_gitmux_color "blue"
set -g @catppuccin_gitmux_text '#(gitmux -cfg $HOME/.config/gitmux/gitmux.yaml "#{pane_current_path}")'

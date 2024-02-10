local wezterm = require("wezterm")

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.cursor_bg = "#89B4FA"
custom.cursor_fg = "#1E1E2E"

wezterm.on("gui-startup", function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
end)

return {
	enable_tab_bar = false,
	allow_square_glyphs_to_overflow_width = "Never",

	font = wezterm.font("FantasqueSansM Nerd Font Mono"),
	automatically_reload_config = true,
	font_size = 12.0,
	line_height = 1.02,

	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	cursor_blink_rate = 0,
	window_decorations = "NONE",

  check_for_updates = false,

	color_schemes = {
		["Custom"] = custom,
	},
	color_scheme = "Custom",
}

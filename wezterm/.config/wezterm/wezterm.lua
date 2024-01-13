local wezterm = require("wezterm")

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

return {
	enable_tab_bar = false,
  allow_square_glyphs_to_overflow_width = "Never",

  font = wezterm.font "FantasqueSansM Nerd Font Mono",
	font_size = 12.0,

	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

  cursor_blink_rate = 0,
	default_cursor_style = "SteadyBlock",
  window_decorations = "NONE",

	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
}

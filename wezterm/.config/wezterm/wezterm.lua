local wezterm = require 'wezterm'

local mocha = wezterm.color.get_builtin_schemes()['Catppuccin Mocha']
mocha.cursor_bg = '#89B4FA'
mocha.cursor_fg = '#1E1E2E'

--[[ wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end) ]]

return {
  initial_rows = 30,
  initial_cols = 100,
  enable_tab_bar = false,
  allow_square_glyphs_to_overflow_width = 'Never',
  notification_handling = 'NeverShow',
  font = wezterm.font_with_fallback {
    {
      family = 'MonaspiceNe Nerd Font',
      -- harfbuzz_features = { 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'calt', 'dlig' },
    },
    {
      family = 'DejaVu Sans Mono',
    },
    --[[ {
      family = 'GeistMono NF',
    }, ]]
    {
      family = 'FantasqueSansM Nerd Font Mono',
    },
  },
  font_rules = {
    {
      intensity = 'Normal',
      italic = true,
      font = wezterm.font {
        family = 'MonaspiceRn Nerd Font',
      },
    },
  },
  automatically_reload_config = true,
  font_size = 12.0,
  line_height = 1.0,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  cursor_blink_rate = 0,
  window_decorations = 'NONE',
  check_for_updates = false,
  color_schemes = {
    ['custom'] = mocha,
  },
  color_scheme = 'custom',
  bidi_enabled = true,
}

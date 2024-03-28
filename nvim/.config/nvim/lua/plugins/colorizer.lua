return {
	"NvChad/nvim-colorizer.lua",
  event = { "BufReadPost", "BufNewFile" },
	opts = {
		filetypes = { "css", "scss", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "astro", "gleam" },
		user_default_options = {
			RRGGBBAA = true,
			rgb_fn = true,
			hsl_fn = true,
			css = true,
			css_fn = true,
			mode = "background", -- Set the display mode.
			tailwind = true,
			sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
			virtualtext = "■",
		},
		buftypes = {},
	},
}

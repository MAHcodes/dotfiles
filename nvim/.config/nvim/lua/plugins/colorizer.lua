return {
	"NvChad/nvim-colorizer.lua",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		filetypes = { "css", "scss", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "astro", "gleam", "lua" },
		user_default_options = {
			RGB = true,
			RRGGBB = true,
			names = false,
			RRGGBBAA = true,
			AARRGGBB = false,
			rgb_fn = true,
			hsl_fn = true,
			css = true,
			css_fn = true,
			mode = "background", -- background | foreground | virtualtext
			tailwind = true,
			sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
			virtualtext = "■",
			virtualtext_inline = true,
			always_update = false,
		},
		buftypes = {},
	},
}

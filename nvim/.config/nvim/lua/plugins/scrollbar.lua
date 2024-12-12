return {
	"petertriho/nvim-scrollbar",
	event = "VeryLazy",
	dependencies = {
		"catppuccin/nvim",
	},
	opts = function()
		local colors = require("catppuccin.palettes").get_palette "mocha"
		return {
			handle = {
				color = colors.surface2,
			},
			marks = {
				Cursor = {
					color = colors.overlay0,
				},
			},
			handlers = {
				cursor = false,
				diagnostic = true,
			},
		}
	end,
}

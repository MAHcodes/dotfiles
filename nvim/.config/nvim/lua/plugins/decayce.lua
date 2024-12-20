return {
	"decaycs/decay.nvim",
	name = "decay",
	lazy = true,
	priority = 1000,
	opts = function()
		local style = "decayce"
		local colors = require("decay.core").get_colors(style)

		return {
			style = style,
			override = {
				-- nvim
				PmenuThumb = { bg = colors.blue },
				NonText = { fg = colors.comments },

				-- alpha
				["AlphaButtons"] = { fg = colors.blue },
				["AlphaShortcut"] = { fg = colors.red, italic = true },
				["AlphaHeader"] = { fg = colors.green },
				["AlphaFooter"] = { fg = colors.magenta, bold = true },
			},
		}
	end,
}

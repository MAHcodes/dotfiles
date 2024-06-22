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
				["@alpha.title"] = { fg = colors.yellow, bold = true },
				["@alpha.text"] = { fg = colors.blue },
				["@alpha.shortcut"] = { fg = colors.red, italic = true },
				["@alpha.header"] = { fg = colors.green },
				["@alpha.footer"] = { fg = colors.magenta, bold = true },
			},
		}
	end,
}

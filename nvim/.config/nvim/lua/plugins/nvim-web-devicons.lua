return {
	"kyazdani42/nvim-web-devicons",
  lazy = true,
	dependencies = {
		{
			"rachartier/tiny-devicons-auto-colors.nvim",
			dependencies = {
				"catppuccin/nvim",
			},
			config = function()
				local theme_colors = require("catppuccin.palettes").get_palette "mocha"

				require("tiny-devicons-auto-colors").setup {
					colors = theme_colors,
				}
			end,
		},
	},
	opts = {
		override = {
			zsh = {
				icon = "",
				color = "#428850",
				cterm_color = "65",
				name = "Zsh",
			},
		},
		color_icons = true,
		default = true,
		strict = true,
		override_by_filename = {
			[".gitignore"] = {
				icon = "",
				color = "#f1502f",
				name = "Gitignore",
			},
		},
		override_by_extension = {
			["log"] = {
				icon = "",
				color = "#81e043",
				name = "Log",
			},
			["gleam"] = {
				icon = "󰦥",
				color = "#ffaff3",
				name = "Gleam",
			},
		},
	},
	config = function(_, opts)
		local nvim_web_devicons = require "nvim-web-devicons"
		nvim_web_devicons.setup(opts)
		local icons = {
			astro = {
				icon = "󱓞",
				color = "#ff7e33",
				name = "Astro",
			},
		}
		nvim_web_devicons.set_icon(icons)
	end,
}

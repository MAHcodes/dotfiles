return {
	"kyazdani42/nvim-web-devicons",
  lazy = true,
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
		},
	},
	config = function(_, opts)
		local nvim_web_devicons = require("nvim-web-devicons")
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

return {
	"rose-pine/neovim",
	name = "rose-pine",
	priority = 1000,
	lazy = true,
	opts = {
		variant = "main",
		dark_variant = "main",
		dim_inactive_windows = true,
		extend_background_behind_borders = false,
		groups = {
			border = "muted",
			link = "iris",
			panel = "surface",

			error = "love",
			hint = "iris",
			info = "foam",
			note = "pine",
			todo = "rose",
			warn = "gold",

			git_add = "foam",
			git_change = "rose",
			git_delete = "love",
			git_dirty = "rose",
			git_ignore = "muted",
			git_merge = "iris",
			git_rename = "pine",
			git_stage = "iris",
			git_text = "rose",
			git_untracked = "subtle",

			h1 = "iris",
			h2 = "foam",
			h3 = "rose",
			h4 = "gold",
			h5 = "pine",
			h6 = "foam",
		},
		highlight_groups = {
			-- nvim
			Comment = { italic = true },
			PmenuThumb = { bg = "rose" },
			Folded = { bg = "surface" },
			TelescopeBorder = { bg = "base" },

			-- alpha
			["AlphaButtons"] = { fg = "foam" },
			["AlphaShortcut"] = { fg = "love", italic = true },
			["AlphaHeader"] = { fg = "iris" },
			["AlphaFooter"] = { fg = "gold", bold = true },

			-- cmp
			CmpItemMenu = { fg = "rose" },
			CmpItemAbbrMatch = { fg = "rose", bold = true },
			CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },

			-- noice
			NoiceCmdlinePopupBorder = { fg = "rose" },
			NoiceVirtualText = { fg = "gold" },
			NoiceLspProgressSuccess = { fg = "foam" },
			NoiceLspProgressSpinner = { fg = "gold" },
			NoicePopupmenuSelected = { fg = "surface", bg = "foam", bold = true },
		},
	},
	config = function(_, opts)
		require("rose-pine").setup(opts)
		vim.cmd.colorscheme "rose-pine"
	end,
}

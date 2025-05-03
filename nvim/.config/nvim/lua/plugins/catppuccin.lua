return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "mocha",
		background = {
			light = "latte",
			dark = "mocha",
		},
		transparent_background = false,
		show_end_of_buffer = false,
		term_colors = false,
		dim_inactive = {
			enabled = false,
			shade = "dark",
			percentage = 0.1,
		},
		no_italic = false,
		no_bold = false,
		no_underline = false,
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
			loops = {},
			functions = {},
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
		},
		color_overrides = {},
		custom_highlights = function(colors)
			return {
				-- nvim
				NormalFloat = { bg = colors.base },
				PmenuThumb = { bg = colors.blue },
				Folded = { bg = colors.surface0 },

				-- nvim-tree
				NvimTreeNormal = { link = "Nvimtree" },

				-- alpha
				["AlphaButtons"] = { fg = colors.blue },
				["AlphaShortcut"] = { fg = colors.red, style = { "italic" } },
				["AlphaHeader"] = { fg = colors.green },
				["AlphaFooter"] = { fg = colors.peach, style = { "bold" } },

				-- cmp
				CmpItemMenu = { fg = colors.blue },
				CmpItemAbbrMatch = { fg = colors.blue, style = { "bold" } },
				CmpItemAbbrMatchFuzzy = { link = "CmpItemAbbrMatch" },

				-- blink.cmp
				BlinkCmpMenu = { link = "BlinkCmpDoc" },
				BlinkCmpMenuBorder = { fg = colors.blue },
				BlinkCmpDocBorder = { fg = colors.blue },
				BlinkCmpDocSeparator = { fg = colors.blue },
				BlinkCmpSignatureHelpBorder = { fg = colors.blue },
				BlinkCmpSource = { fg = colors.blue },

				-- noice
				NoiceCmdlinePopupBorder = { fg = colors.blue },
				NoiceVirtualText = { fg = colors.yellow },
				NoiceLspProgressSuccess = { fg = colors.green },
				NoiceLspProgressSpinner = { fg = colors.yellow },
				NoicePopupmenuSelected = { fg = colors.surface0, bg = colors.blue, style = { "bold" } },
			}
		end,
		integrations = {
			alpha = true,
			blink_cmp = true,
			gitsigns = true,
			nvimtree = true,
			treesitter = true,
			octo = true,
			notify = true,
			markdown = true,
			harpoon = true,
			fidget = true,
			illuminate = true,
			mason = true,
			neogit = true,
			noice = true,
			symbols_outline = true,
			lsp_trouble = true,
			which_key = true,
			barbecue = {
				dim_dirname = true,
				bold_basename = true,
				dim_context = false,
				alt_background = false,
			},
			telescope = {
				enabled = true,
			},
			dap = {
				enabled = true,
				enable_ui = true,
			},
			indent_blankline = {
				enabled = true,
				colored_indent_levels = false,
			},
			navic = {
				enabled = true,
			},
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme "catppuccin"
	end,
}

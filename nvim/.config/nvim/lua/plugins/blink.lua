return {
	"saghen/blink.cmp",
	enabled = true,
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"moyiz/blink-emoji.nvim",
		"MahanRahmati/blink-nerdfont.nvim",
		"mikavilpas/blink-ripgrep.nvim",
		{
			"Kaiser-Yang/blink-cmp-git",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},
	version = "1.*",

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			menu = {
				auto_show = true,
				border = "rounded",
				draw = {
					align_to = "none",
					columns = {
						{ "source_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
					},
					components = {
						source_icon = {
							width = { max = 30 },
							text = function(ctx)
								local icons = require "user.icons"
								local source_icons = {
									lsp = icons.menu.Plug,
									path = icons.menu.FilePath,
									snippets = icons.menu.Scissors,
									luasnip = icons.menu.Lua,
									buffer = icons.menu.Word,
									emoji = icons.menu.Smiley,
									nerdfont = icons.menu.Glass,
									ripgrep = icons.menu.TextSearch,
									git = icons.menu.Git,
									cmdline = icons.menu.Cmd,
								}
								local source_icon = source_icons[ctx.source_id] or ctx.source_id
								return string.format("%s %s", source_icon, "")
							end,
							highlight = "BlinkCmpSource",
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				window = {
					border = "rounded",
				},
			},
			ghost_text = {
				enabled = true,
			},
		},
		signature = {
			enabled = true,
			window = {
				border = "rounded",
			},
		},
		sources = {
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
				"emoji",
				"nerdfont",
				"ripgrep",
				"git",
			},
			providers = {
				emoji = {
					module = "blink-emoji",
					name = "Emoji",
				},
				nerdfont = {
					module = "blink-nerdfont",
					name = "Nerd Fonts",
				},
				ripgrep = {
					module = "blink-ripgrep",
					name = "Ripgrep",
				},
				git = {
					module = "blink-cmp-git",
					name = "Git",
					enabled = function()
						return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
					end,
				},
			},
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
		},
	},
	opts_extend = {
		"sources.default",
	},
}

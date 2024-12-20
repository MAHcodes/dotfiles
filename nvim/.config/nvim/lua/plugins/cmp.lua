return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"FelipeLema/cmp-async-path",
		"hrsh7th/cmp-cmdline",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-emoji",
		"hrsh7th/cmp-calc",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"chrisgrieser/cmp-nerdfont",
		"roobert/tailwindcss-colorizer-cmp.nvim",
		"rasulomaroff/cmp-bufname",
	},
	config = function()
		local cmp = require "cmp"
		local luasnip = require "luasnip"
		local icons = require "user.icons"

		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			completion = { completeopt = "menu,menuone,preview,noinsert,noselect" },
			mapping = {
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-y>"] = cmp.mapping.confirm { select = true },
				["<C-e>"] = cmp.mapping {
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				},
				["<C-a>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			},
			formatting = {
				fields = { "menu", "abbr", "kind" },
				format = function(entry, vim_item)
					local kind = vim_item.kind
					vim_item.kind = string.format(" %s %s", icons.kind[kind], kind)

					local menu = {
						nvim_lsp = { title = "LSP", icon = icons.menu.Plug },
						luasnip = { title = "Snip", icon = icons.menu.Scissors },
						nvim_lua = { title = "Lua", icon = icons.menu.Lua },
						buffer = { title = "Buf", icon = icons.menu.File },
						bufname = { title = "Buf", icon = icons.menu.Word },
						async_path = { title = "Path", icon = icons.menu.FilePath },
						emoji = { title = "Emo", icon = icons.menu.Smiley },
						nerdfont = { title = "NF", icon = icons.menu.Glass },
						calc = { title = "Calc", icon = icons.menu.Calc },
						nvim_lsp_signature_help = { title = "Sig", icon = icons.menu.Help },
					}

					vim_item.menu = string.format("%s %s", menu[entry.source.name].icon, icons.ui.LineMiddle)

					-- return vim_item
					return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
				end,
			},
			sources = {
				{ name = "nvim_lsp_signature_help" },
				{ name = "nvim_lsp" },
				{ name = "bufname" },
				{ name = "buffer" },
				{ name = "luasnip" },
				{ name = "nvim_lua" },
				{ name = "async_path" },
				{ name = "calc" },
				{ name = "emoji" },
				{ name = "nerdfont" },
			},
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			view = {
				entries = {
					entries = {
						name = "custom",
						selection_order = "near_cursor",
					},
				},
			},
		}
	end,
}

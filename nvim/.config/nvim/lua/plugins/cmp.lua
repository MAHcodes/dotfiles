return {
	"hrsh7th/nvim-cmp",
	lazy = true,
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
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					local kind = vim_item.kind

					vim_item.kind = (" " .. icons.kind[kind] or "?" .. " ")

					vim_item.menu = "["
						.. ({
							nvim_lsp = "󰚥",
							luasnip = "",
							nvim_lua = "󰢱",
							buffer = "",
							async_path = "",
							emoji = "󰱫",
							nerdfont = "󰊪",
							calc = "󰃬",
							bufname = "󰈬",
						})[entry.source.name]
						.. " "
						.. kind
						.. "]"

					-- return vim_item
					return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
				end,
			},
			sources = {
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
					name = "custom",
				},
			},
		}
	end,
}

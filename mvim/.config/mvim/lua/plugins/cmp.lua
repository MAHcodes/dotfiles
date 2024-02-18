return {
	"hrsh7th/nvim-cmp",
  lazy = true,
	event = "InsertEnter",
	dependencies = {
		{
			"hrsh7th/cmp-buffer",
			event = "InsertEnter",
		},
		{
			"FelipeLema/cmp-async-path",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-cmdline",
			event = "InsertEnter",
		},
		{
			"saadparwaiz1/cmp_luasnip",
			event = "InsertEnter",
		},
		{
			"L3MON4D3/LuaSnip",
      lazy = true
		},
		{
			"hrsh7th/cmp-nvim-lsp",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-nvim-lua",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-emoji",
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-calc",
			event = "InsertEnter",
		},
		{
			"chrisgrieser/cmp-nerdfont",
			event = "InsertEnter",
		},
		{
			"roobert/tailwindcss-colorizer-cmp.nvim",
			event = "InsertEnter",
		},
		{
			"rasulomaroff/cmp-bufname",
			event = "InsertEnter",
		},
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
    local icons = require("user.icons")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
				["<C-a>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
				["<C-e>"] = cmp.mapping({
					i = cmp.mapping.abort(),
					c = cmp.mapping.close(),
				}),
				-- Accept currently selected item. If none selected, `select` first item.
				-- Set `select` to `false` to only confirm explicitly selected items.
				["<CR>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() and cmp.get_selected_entry() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
						else
							fallback()
						end
					end,
					s = cmp.mapping.confirm({ select = true }),
					c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					-- vim_item.kind = string.format("%s", icons.kind[vim_item.kind])
					vim_item.kind = string.format('%s %s', icons.kind[vim_item.kind], vim_item.kind)
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						nvim_lua = "[LUA_LSP]",
						buffer = "[Buffer]",
						path = "[Path]",
						emoji = "[Emoji]",
						nerdfont = "[NF]",
						calc = "[Calc]",
						bufname = "[BUFNAME]",
					})[entry.source.name]

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
				select = false,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			view = {
				entries = "cmp",
			},
			experimental = {
				ghost_text = true,
			},
		})
	end,
}

return {
	"L3MON4D3/LuaSnip",
  event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
    lazy = true,
	},
	config = function()
		local ls = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Shorten function name
		local keymap = vim.keymap.set

		local opts = { noremap = true, silent = true }

		keymap({ "i" }, "<C-K>", function()
			ls.expand()
		end, opts)
		keymap({ "i", "s" }, "<C-n>", function()
			ls.jump(1)
		end, opts)
		keymap({ "i", "s" }, "<C-p>", function()
			ls.jump(-1)
		end, opts)

		keymap({ "i", "s" }, "<C-E>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, opts)
	end,
}

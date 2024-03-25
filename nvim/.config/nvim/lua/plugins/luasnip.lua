return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
		lazy = true,
	},
	config = function()
		local ls = require "luasnip"
		require("luasnip.loaders.from_vscode").lazy_load()
		local map = vim.keymap.set

		map({ "i" }, "<C-k>", function()
			ls.expand()
		end)
		map({ "i", "s" }, "<C-l>", function()
			ls.jump(1)
		end)
		map({ "i", "s" }, "<C-h>", function()
			ls.jump(-1)
		end)

		map({ "i", "s" }, "<C-o>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end)
	end,
}

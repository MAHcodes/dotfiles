return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 1000
	end,
	opts = {
		notify = false,
		win = {
			border = "rounded",
			title = true,
			title_pos = "center",
			height = {
				min = 4,
				max = vim.o.lines,
			},
			padding = { 1, 2 },
			zindex = 1000,
			wo = {
				winblend = 0,
			},
		},
		layout = {
			spacing = 4,
		},
		show_help = false,
		show_keys = true,
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show { global = false }
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	config = function(_, opts)
		local wk = require "which-key"
		wk.add(require("plugins.lspconfig").whichkey)
		wk.add(require("plugins.harpoon").whichkey)
		wk.add { "<leader>l", group = "LSP" }
		wk.add(require("plugins.rest").whichkey)
		wk.add { "<leader>g", group = "Git" }
		wk.add(require("plugins.dap").whichkey)

		wk.setup(opts)
	end,
}

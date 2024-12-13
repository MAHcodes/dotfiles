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
		local icons = require "user.icons"
		wk.add { "<leader>s", group = "Search" }
		wk.add { "<leader>h", group = "Harpoon", icon = icons.misc.ArrowProjectile }
		wk.add { "<leader>l", group = "LSP" }
		wk.add { "<leader>r", group = "Rest" }
		wk.add { "<leader>g", group = "Git" }
		wk.add { "<leader>d", group = "Dap" }

		wk.setup(opts)
	end,
}

return {
	"folke/todo-comments.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		highlight = {
			pattern = [[.*<(KEYWORDS)\s*:?]],
		},
		search = {
			pattern = [[\b(KEYWORDS):?]],
		},
	},
	config = function(_, opts)
		local todocomments = require "todo-comments"
		local map = vim.keymap.set

		map("n", "]t", todocomments.jump_next, { desc = "Next todo comment" })
		map("n", "[t", todocomments.jump_prev, { desc = "Previous todo comment" })
		map("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "Search Todo" })

		todocomments.setup(opts)
	end,
}

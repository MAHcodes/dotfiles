return {
	"folke/todo-comments.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim", lazy = true },
	config = function()
		local todocomments = require "todo-comments"
		todocomments.setup()

		vim.keymap.set("n", "]t", function()
			todocomments.jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[t", function()
			todocomments.jump_prev()
		end, { desc = "Previous todo comment" })
	end,
}

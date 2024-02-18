return {
	"folke/todo-comments.nvim",
  lazy = true,
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim", lazy = true },
	config = function()
    require("todo-comments").setup()

		vim.keymap.set("n", "]t", function()
			require("todo-comments").jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[t", function()
			require("todo-comments").jump_prev()
		end, { desc = "Previous todo comment" })
	end,
}

return {
	"otavioschwanck/arrow.nvim",
  enabled = false,
	opts = {
		always_show_path = false,
		hide_handbook = true,
		mappings = {
			edit = "e",
			delete_mode = "d",
			clear_all_items = "C",
			toggle = "t",
			open_vertical = "v",
			open_horizontal = "-",
			quit = "q",
			remove = "x",
		},
		window = {
			border = "rounded",
		},
		leader_key = "<leader>a",
		index_keys = "123456789",
	},
	config = function(_, opts)
		local map = vim.keymap.set
		local ap = require "arrow.persist"

		map("n", "<leader>ap", ap.previous, { desc = "Arrow Prev", nowait = true })
		map("n", "<leader>an", ap.next, { desc = "Arrow Next", nowait = true })

		require("arrow").setup(opts)
	end,
}

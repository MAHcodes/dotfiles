return {
	"ruifm/gitlinker.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		mappings = nil,
	},
	keys = {
		{
			"<leader>gk",
			"<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.copy_to_clipboard})<cr>",
			desc = "Copy URL",
		},
		{
			"<leader>gK",
			"<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
			desc = "Open URL",
		},
		{
			"<leader>gk",
			"<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.copy_to_clipboard})<cr>",
			desc = "Copy URL",
			mode = "v",
		},
		{
			"<leader>gK",
      "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
			desc = "Open URL",
			mode = "v",
		},
	},
}

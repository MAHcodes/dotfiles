return {
	"kylechui/nvim-surround",
  lazy = true,
  event = "VeryLazy",
	opts = {
		keymaps = {
			insert = "<C-g>s",
			insert_line = "<C-g>S",
			normal = "s",
			normal_cur = "ss",
			normal_line = "S",
			normal_cur_line = "SS",
			visual = "s",
			visual_line = "gS",
			delete = "sd",
			change = "sc",
		},
	},
}

return {
	"kylechui/nvim-surround",
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
			visual_line = "<Nop>",
			delete = "sd",
			change = "sc",
		},
	},
}

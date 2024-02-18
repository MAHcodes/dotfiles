return {
	"kevinhwang91/nvim-bqf",
	name = "bqt",
  lazy = true,
  event = "VeryLazy",
	opts = {
		auto_enable = true,
		auto_resize_height = true,
		preview = {
			win_height = 20,
			win_vheight = 12,
			delay_syntax = 80,
			winblend = 0,
			show_title = true,
			border = "rounded",
		},
	},
}

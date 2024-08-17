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
			padding = { 1, 2 },
			zindex = 1000,
		},
		layout = {
			spacing = 4,
		},
		show_help = false,
		show_keys = false,
	},
}

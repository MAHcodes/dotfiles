return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 1000
	end,
	opts = {
		window = {
			border = "rounded",
			position = "bottom",
			margin = { 1, 0, 1, 0 },
			padding = { 1, 1, 1, 1 },
			winblend = 0,
			zindex = 1000,
		},
		layout = {
			spacing = 4,
			align = "center",
		},
		show_help = false,
		show_keys = false,
		triggers_nowait = { "`", "'", "g`", "g'", '"', "<c-r>", "z=" },
	},
}

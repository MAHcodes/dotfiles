return {
	"folke/zen-mode.nvim",
	cmd = "ZenMode",
	opts = {
		plugins = {
			options = {
				enabled = true,
				laststatus = 0,
			},
			tmux = { enabled = true },
		},
	},
}

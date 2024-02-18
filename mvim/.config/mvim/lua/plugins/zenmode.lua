return {
	"folke/zen-mode.nvim",
  lazy = true,
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

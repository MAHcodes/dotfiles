return {
	"aserowy/tmux.nvim",
	event = "UIEnter",
	opts = {
		copy_sync = {
			-- syncs the unnamed register to the tmux buffer by embedding the whole
			-- yanked content in a shell command, which crashes on large yanks (E2BIG)
			enable = false,
		},
	},
	config = function(_, opts)
		require("tmux").setup(opts)
	end,
}

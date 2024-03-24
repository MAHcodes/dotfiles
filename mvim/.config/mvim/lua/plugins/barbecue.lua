return {
	"utilyre/barbecue.nvim",
	event = { "BufRead", "BufWinEnter", "BufNewFile" },
	requires = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		exclude_filetypes = { "gitcommit" },
		show_modified = true,
		symbols = {
			modified = "●",
			ellipsis = "…",
			separator = "",
		},
	},
}

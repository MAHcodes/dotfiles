return {
	"utilyre/barbecue.nvim",
	event = { "BufRead", "BufWinEnter", "BufNewFile" },
	requires = {
		{
			"SmiteshP/nvim-navic",
			lazy = true,
		},
		{
			"nvim-tree/nvim-web-devicons",
			lazy = true,
		},
	},
	opts = {
		exclude_filetypes = { "gitcommit", "toggleterm" },
	},
}

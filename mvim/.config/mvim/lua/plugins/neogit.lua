return {
	"NeogitOrg/neogit",
  event = "VeryLazy",
	dependencies = {
		{
			"nvim-lua/plenary.nvim",
			lazy = true,
		},
		{
			"sindrets/diffview.nvim",
			lazy = true,
		},
		{
			"nvim-telescope/telescope.nvim",
			lazy = true,
		},
	},
	config = true,
}

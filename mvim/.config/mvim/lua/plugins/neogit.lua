return {
	"NeogitOrg/neogit",
  cmd = "Neogit",
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

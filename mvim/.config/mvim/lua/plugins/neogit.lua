return {
	"NeogitOrg/neogit",
	cmd = "Neogit",
	keys = {
		{
			"<leader>gg",
			"<cmd>Neogit<CR>",
			desc = "Neogit",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = true,
}

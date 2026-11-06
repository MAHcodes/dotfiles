return {
	"jiaoshijie/undotree",
	dependencies = "nvim-lua/plenary.nvim",
	opts = {
    float_diff = false,
		window = {
			winblend = 0,
		},
	},
	keys = {
		{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>", desc = "Toggle UndoTree" },
	},
}

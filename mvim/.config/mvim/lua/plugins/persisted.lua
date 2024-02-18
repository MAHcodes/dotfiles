return {
	"olimorris/persisted.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		lazy = true,
	},
	opts = {
		should_autosave = function()
			if vim.bo.filetype == "alpha" then
				return false
			end
			return true
		end,
	},
	config = function(_, opts)
		require("persisted").setup(opts)

		require("telescope").load_extension("persisted")
	end,
}

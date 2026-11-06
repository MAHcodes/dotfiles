return {
	"olimorris/persisted.nvim",
	enabled = true,
	cmd = {
		"Persisted",
	},
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		should_save = function()
			if vim.bo.filetype == "alpha" then
				return false
			end
			return true
		end,
	},
	config = function(_, opts)
		require("persisted").setup(opts)

		require("telescope").load_extension "persisted"
	end,
}

return {
	"olimorris/persisted.nvim",
	cmd = {
		"SessionToggle",
		"SessionStart",
		"SessionStop",
		"SessionSave",
		"SessionLoad",
		"SessionLoadLast",
		"SessionLoadFromFile",
		"SessionDelete",
	},
	dependencies = {
		"nvim-telescope/telescope.nvim",
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

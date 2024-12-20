return {
	"stevearc/dressing.nvim",
  lazy = true,
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	opts = function()
		local theme_opts = require("plugins.telescope").theme_opts
		return {
			select = {
				enabled = true,
				backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
				telescope = theme_opts,
			},
		}
	end,
}

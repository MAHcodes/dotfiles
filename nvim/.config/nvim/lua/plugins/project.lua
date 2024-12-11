return {
	"ahmedkhalf/project.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	keys = {
		{
			"<leader>sp",
			function()
				local telescope = require "telescope"
				local theme_opts = require("plugins.telescope").theme_opts
				telescope.extensions.projects.projects(theme_opts)
			end,
			desc = "Search Projects",
		},
	},
	opts = {
		active = true,
		detection_methods = { "pattern" },
		exclude_dirs = { "*/node_modules/*" },
		patterns = { ".git", "Makefile", "package.json", "gleam.toml", "go.mod" },
		show_hidden = true,
	},
	config = function(_, opts)
		require("project_nvim").setup(opts)
		require("telescope").load_extension "projects"
	end,
}

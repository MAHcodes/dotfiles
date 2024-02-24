return {
	"ahmedkhalf/project.nvim",
	event = "VimEnter",
	opts = {
		active = true,
		detection_methods = { "pattern" },
		exclude_dirs = { "*/node_modules/*" },
		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "lazy-lock.json" },
		show_hidden = true,
	},
	config = function(_, opts)
		require("project_nvim").setup(opts)
		require("telescope").load_extension("projects")
	end,
}

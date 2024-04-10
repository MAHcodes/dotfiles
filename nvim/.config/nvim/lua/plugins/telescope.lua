local M = {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"rcarriga/nvim-notify",
			lazy = true,
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable "make" == 1
			end,
			lazy = true,
		},
		{
			"ahmedkhalf/project.nvim",
			opts = {
				active = true,
				detection_methods = { "pattern" },
				exclude_dirs = { "*/node_modules/*" },
				patterns = { ".git", "Makefile", "package.json", "gleam.toml", "go.mod" },
				show_hidden = true,
			},
			config = function(_, opts)
				require("project_nvim").setup(opts)
			end,
		},
	},
}

M.cmd = "Telescope"

M.theme = function(func)
	return function()
		func(require("telescope.themes").get_ivy {
			layout_config = {
				height = vim.o.lines,
			},
		})
	end
end

M.keys = function()
	local t = require "telescope"
	local tb = require "telescope.builtin"
	return {
		{ "<leader>sh", M.theme(tb.help_tags), desc = "Search Help" },
		{ "<leader>si", M.theme(tb.highlights), desc = "Search Highlights" },
		{ "<leader>sc", M.theme(tb.colorscheme), desc = "Search Colorscheme" },
		{ "<leader>sg", M.theme(tb.git_files), desc = "Search Git Files" },
		{ "<leader>st", M.theme(tb.git_status), desc = "Search Git Status" },
		{ "<leader>sB", M.theme(tb.git_branches), desc = "Search Git Branches" },
		{ "<leader>sC", M.theme(tb.git_commits), desc = "Search Git Commits" },
		{ "<leader>sk", M.theme(tb.keymaps), desc = "Search Keymaps" },
		{ "<leader>sf", M.theme(tb.find_files), desc = "Search Files" },
		{ "<leader>sa", M.theme(tb.builtin), desc = "Search All" },
		{ "<leader>sw", M.theme(tb.grep_string), desc = "Search Word" },
		{ "<leader>sm", M.theme(tb.man_pages), desc = "Search Man Pges" },
		{ "<leader>sl", M.theme(tb.live_grep), desc = "Search Grep" },
		{ "<leader>sd", M.theme(tb.diagnostics), desc = "Search Diagnostics" },
		{ "<leader>sr", M.theme(tb.resume), desc = "Search Resume" },
		{ "<leader>so", M.theme(tb.oldfiles), desc = "Search Oldfiles" },
		{ "<leader>sb", M.theme(tb.buffers), desc = "Search Buffers" },
		{ "<leader>s/", M.theme(tb.current_buffer_fuzzy_find), desc = "Search" },
		{ "<leader>ss", M.theme(t.extensions.persisted.persisted), desc = "Search Sessions" },
		{ "<leader>sp", M.theme(t.extensions.projects.projects), desc = "Search Projects" },
		{ "<leader>sn", M.theme(t.extensions.notify.notify), desc = "Search Notifications" },
	}
end

M.opts = {
	defaults = {
		prompt_prefix = "  ",
		selection_caret = " ",
		path_display = { "truncate" },
		layout_strategy = "horizontal",
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
		},
		dynamic_preview_title = true,
		file_ignore_patterns = {
			".git/",
			".next/",
			"target/",
			"vendor/*",
			"%.lock",
			"__pycache__/*",
			"%.sqlite3",
			"%.ipynb",
			"node_modules/*",
			"%.otf",
			"%.ttf",
			"%.webp",
			".dart_tool/",
			".github/",
			".gradle/",
			".idea/",
			".vscode/",
			"__pycache__/",
			"build/",
			"env/",
			"gradle/",
			"node_modules/",
			"%.pdb",
			"%.dll",
			"%.class",
			"%.cache",
			"%.ico",
			"%.pdf",
			"%.dylib",
			"%.jar",
			"%.docx",
			"%.met",
			"smalljre_*/*",
			".vale/",
			"%.burp",
			"%.mp4",
			"%.mkv",
			"%.rar",
			"%.zip",
			"%.7z",
			"%.tar",
			"%.bz2",
			"%.epub",
			"%.flac",
			"%.tar.gz",
			"stats.html",
			"%.png",
			"%.jpg",
		},
	},
	pickers = {
		find_files = {
			theme = "ivy",
			previewer = true,
			hidden = true,
			no_ignore = false,
			layout_config = {
				height = vim.o.lines,
			},
		},
	},
}

M.config = function(_, opts)
	require("telescope").setup(opts)
	pcall(require("telescope").load_extension, "fzf")
	pcall(require("telescope").load_extension, "projects")
end

return M

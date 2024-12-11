local M = {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"rcarriga/nvim-notify",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable "make" == 1
			end,
		},
	},
}

M.cmd = "Telescope"

M.theme_opts = require("telescope.themes").get_ivy {
	prompt_prefix = "  ",
	selection_caret = " ",
	path_display = {
		"filename_first",
		"truncate",
	},
	sorting_strategy = "ascending",
	previewer = true,
	results_title = false,
	dynamic_preview_title = true,
	layout_config = {
		prompt_position = "top",
		height = vim.o.lines,
		width = vim.o.columns,
	},
}

M.theme = function(picker, opts)
	return function()
		picker(vim.tbl_deep_extend("force", M.theme_opts, opts or {}))
	end
end

M.keys = function()
	local t = require "telescope"
	local tb = require "telescope.builtin"
	return {
		{ "<leader>sh", tb.help_tags, desc = "Search Help" },
		{ "<leader>si", tb.highlights, desc = "Search Highlights" },
		{ "<leader>sc", tb.colorscheme, desc = "Search Colorscheme" },
		{ "<leader>sg", tb.git_files, desc = "Search Git Files" },
		{ "<leader>su", tb.git_status, desc = "Search Git Status" },
		{ "<leader>sB", tb.git_branches, desc = "Search Git Branches" },
		{ "<leader>sC", tb.git_commits, desc = "Search Git Commits" },
		{ "<leader>sk", tb.keymaps, desc = "Search Keymaps" },
		{
			"<leader>sf",
			function()
				tb.find_files {
					hidden = true,
					no_ignore = false,
				}
			end,
			desc = "Search Files",
		},
		{ "<leader>sa", tb.builtin, desc = "Search All" },
		{ "<leader>sw", tb.grep_string, desc = "Search Word" },
		{ "<leader>sm", tb.man_pages, desc = "Search Man Pges" },
		{ "<leader>sl", tb.live_grep, desc = "Search Grep" },
		{ "<leader>sd", tb.diagnostics, desc = "Search Diagnostics" },
		{ "<leader>sr", tb.resume, desc = "Search Resume" },
		{ "<leader>so", tb.oldfils, desc = "Search Oldfiles" },
		{ "<leader>sb", tb.buffers, desc = "Search Buffers" },
		{ "<leader>s/", tb.current_buffer_fuzzy_find, desc = "Search" },
		{ "<leader>sn", t.extensions.notify.notify, desc = "Search Notifications" },
	}
end

M.opts = {
	defaults = M.theme_opts,
}

M.config = function(_, opts)
	require("telescope").setup(opts)
	pcall(require("telescope").load_extension, "fzf")
end

return M

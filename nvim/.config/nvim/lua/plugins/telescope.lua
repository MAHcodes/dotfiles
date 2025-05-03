local M = {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
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

local icons = require "user.icons"

M.theme_opts = require("telescope.themes").get_ivy {
	prompt_prefix = icons.ui.Telescope .. " ",
	selection_caret = icons.ui.Forward .. " ",
	entry_prefix = "  ",
	multi_icon = icons.ui.TriangleShortArrowRight .. " ",
	path_display = {
		"filename_first",
		"truncate",
	},
	sorting_strategy = "ascending",
	previewer = true,
	results_title = false,
	dynamic_preview_title = true,
	file_ignore_patterns = { ".git" },
	layout_config = {
		prompt_position = "top",
		height = vim.o.lines,
	},
}

M.theme = function(picker, opts)
	return function()
		picker(vim.tbl_deep_extend("force", M.theme_opts, opts or {}))
	end
end

local find_lazy = function()
	local actions = require "telescope.actions"
	local action_state = require "telescope.actions.state"
	local finders = require "telescope.finders"
	local pickers = require "telescope.pickers"
	local conf = require("telescope.config").values

	local lazy_path = vim.fn.stdpath "data" .. "/lazy"

	local plugins = vim.fn.globpath(lazy_path, "*", 0, 1)

	pickers
		.new({}, {
			prompt_title = "Search Lazy",
			finder = finders.new_table {
				results = plugins,
				entry_maker = function(plugin_path)
					return {
						value = plugin_path,
						display = vim.fn.fnamemodify(plugin_path, ":t"),
						ordinal = vim.fn.fnamemodify(plugin_path, ":t"),
					}
				end,
			},
			sorter = conf.generic_sorter {},
			attach_mappings = function(prompt_bufnr, map)
				local open_files = function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if selection then
						require("telescope.builtin").git_files {
							prompt_title = "Find Files in " .. selection.display,
							cwd = selection.value,
						}
					end
				end

				map("i", "<CR>", open_files)
				map("n", "<CR>", open_files)
				return true
			end,
		})
		:find()
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
		{ "<leader>sf", tb.find_files, desc = "Search Files" },
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
		{ "<leader>sz", find_lazy, desc = "Search Lazy" },
	}
end

M.opts = {
	defaults = M.theme_opts,
	pickers = {
		find_files = {
			hidden = true,
			no_ignore = false,
		},
	},
	extensions = {
		fzf = {},
	},
}

M.config = function(_, opts)
	require("telescope").setup(opts)
	require("telescope").load_extension "fzf"
end

return M

local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"ahmedkhalf/project.nvim",
			lazy = true,
		},
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
		{ "<leader>/", M.theme(tb.current_buffer_fuzzy_find), desc = "Search" },
		{ "<leader>sp", M.theme(t.extensions.projects.projects), desc = "Search projects" },
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
end

return M

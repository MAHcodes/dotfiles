local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
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
	local tb = require "telescope.builtin"
	return {
		{ "<leader>sh", M.theme(tb.help_tags), desc = "Search Help" },
		{ "<leader>si", M.theme(tb.highlights), desc = "Search Highlights" },
		{ "<leader>sc", M.theme(tb.colorscheme), desc = "Search Colorscheme" },
		{ "<leader>sg", M.theme(tb.git_files), desc = "Search Git Files" },
		{ "<leader>sk", M.theme(tb.keymaps), desc = "Search Keymaps" },
		{ "<leader>sf", M.theme(tb.find_files), desc = "Search Files" },
		{ "<leader>ss", M.theme(tb.builtin), desc = "Search Search" },
		{ "<leader>sw", M.theme(tb.grep_string), desc = "Search Word" },
		{ "<leader>sl", M.theme(tb.live_grep), desc = "Search Grep" },
		{ "<leader>sd", M.theme(tb.diagnostics), desc = "Search Diagnostics" },
		{ "<leader>sr", M.theme(tb.resume), desc = "Search Resume" },
		{ "<leader>so", M.theme(tb.oldfiles), desc = "Search Oldfiles" },
		{ "<leader>sb", M.theme(tb.buffers), desc = "Search Buffers" },
	}
end

M.opts = function()
	local actions = require "telescope.actions"
	return {
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
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-n>"] = actions.move_selection_next,
					["<C-p>"] = actions.move_selection_previous,
					["<C-c>"] = actions.close,
					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,
					["<CR>"] = actions.select_default,
					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,
					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,
					["<C-f>"] = require("telescope.actions").delete_buffer,
					["<PageUp>"] = actions.results_scrolling_up,
					["<PageDown>"] = actions.results_scrolling_down,
					["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
					["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					["<C-l>"] = actions.complete_tag,
					["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
				},
				n = {
					["<esc>"] = actions.close,
					["<CR>"] = actions.select_default,
					["<C-x>"] = actions.select_horizontal,
					["<C-v>"] = actions.select_vertical,
					["<C-t>"] = actions.select_tab,
					["q"] = actions.close,
					["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
					["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
					["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
					["n"] = actions.move_selection_next,
					["p"] = actions.move_selection_previous,
					["H"] = actions.move_to_top,
					["M"] = actions.move_to_middle,
					["L"] = actions.move_to_bottom,
					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,
					["gg"] = actions.move_to_top,
					["G"] = actions.move_to_bottom,
					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,
					["<PageUp>"] = actions.results_scrolling_up,
					["<PageDown>"] = actions.results_scrolling_down,
					["dd"] = require("telescope.actions").delete_buffer,
					["?"] = actions.which_key,
				},
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
end

M.config = function(_, opts)
	require("telescope").setup(opts)
	pcall(require("telescope").load_extension, "fzf")
end

return M

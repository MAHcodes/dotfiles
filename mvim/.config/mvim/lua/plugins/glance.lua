return {
	"dnlhc/glance.nvim",
	keys = {
		{
			"gd",
			"<CMD>Glance definitions<CR>",
			desc = "Definitions",
		},
		{
			"gr",
			"<CMD>Glance references<CR>",
			desc = "References",
		},
		{
			"gD",
			"<CMD>Glance type_definitions<CR>",
			desc = "Type Definitions",
		},
		{
			"gi",
			"<CMD>Glance implementations<CR>",
			desc = "Implementations",
		},
	},
	opts = function()
		local actions = require("glance").actions

		return {
			height = 25,
			zindex = 45,
			detached = function(winid)
				return vim.api.nvim_win_get_width(winid) < 100
			end,
			preview_win_opts = {
				cursorline = true,
				number = true,
				wrap = true,
			},
			border = {
				enable = true,
				top_char = "―",
				bottom_char = "―",
			},
			list = {
				position = "right",
				width = 0.33,
			},
			theme = {
				enable = true,
				mode = "auto",
			},
			mappings = {
				list = {
					["j"] = actions.next,
					["k"] = actions.previous,
					["n"] = actions.next_location,
					["p"] = actions.previous_location,
					["<C-u>"] = actions.preview_scroll_win(5),
					["<C-d>"] = actions.preview_scroll_win(-5),
					["v"] = actions.jump_vsplit,
					["s"] = actions.jump_split,
					["t"] = actions.jump_tab,
					["<CR>"] = actions.jump,
					["o"] = actions.jump,
					["l"] = actions.open_fold,
					["h"] = actions.close_fold,
					["<TAB>"] = actions.enter_win("preview"),
					["q"] = actions.close,
					["<Esc>"] = actions.close,
					["<C-q>"] = actions.quickfix,
				},
				preview = {
					["q"] = actions.close,
					["n"] = actions.next_location,
					["p"] = actions.previous_location,
					["<TAB>"] = actions.enter_win("list"),
				},
			},
			hooks = {},
			folds = {
				fold_closed = "",
				fold_open = "",
				folded = false,
			},
			indent_lines = {
				enable = true,
				icon = "▏",
			},
			winbar = {
				enable = true,
			},
		}
	end,
}

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufRead", "BufWinEnter", "BufNewFile" },
	cmd = "Gitsigns",
	keys = {
		{
			"<leader>gp",
			"<cmd>Gitsigns prev_hunk<cr>",
			"Prev Hunk",
		},
		{
			"<leader>gn",
			"<cmd>Gitsigns next_hunk<cr>",
			desc = "Next Hunk",
		},
		{
			"<leader>gl",
			"<cmd>Gitsigns blame_line<cr>",
			desc = "Blame Line",
		},
		{
			"<leader>gv",
			"<cmd>Gitsigns preview_hunk<cr>",
			desc = "Preview Hunk",
		},
		{
			"<leader>gr",
			"<cmd>Gitsigns reset_hunk<cr>",
			desc = "Reset Hunk",
		},
		{
			"<leader>gR",
			"<cmd>Gitsigns reset_buffer<cr>",
			desc = "Reset Buffer",
		},
		{
			"<leader>gs",
			"<cmd>Gitsigns stage_hunk<cr>",
			desc = "Stage Hunk",
		},
		{
			"<leader>gS",
			"<cmd>Gitsigns stage_buffer<cr>",
			desc = "Stage Buffer",
		},
		{
			"<leader>gu",
			"<cmd>Gitsigns undo_stage_hunk<cr>",
			desc = "Undo Stage Hunk",
		},
	},
	opts = {
		signs = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "󰐊" },
			topdelete = { text = "󰐊" },
			changedelete = { text = "▎" },
			untracked = { text = "┆" },
		},
		signs_staged = {
			add = { text = "▎" },
			change = { text = "▎" },
			delete = { text = "󰐊" },
			topdelete = { text = "󰐊" },
			changedelete = { text = "▎" },
			untracked = { text = "┆" },
		},
		signs_staged_enable = true,
		signcolumn = true,
		numhl = true,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 0,
			ignore_whitespace = false,
		},
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000,
		preview_config = {
			-- Options passed to nvim_open_win
			border = "rounded",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	},
}

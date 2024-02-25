return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 1000
	end,
	opts = {
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			presets = {
				operators = true,
				motions = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
		key_labels = {},
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},
		popup_mappings = {
			scroll_down = "<c-d>",
			scroll_up = "<c-u>",
		},
		window = {
			border = "rounded",
			position = "bottom",
			margin = { 1, 0, 1, 0 },
			padding = { 1, 1, 1, 1 },
			winblend = 0,
		},
		layout = {
			height = { min = 5, max = 25 },
			width = { min = 20, max = 50 },
			spacing = 4,
			align = "center",
		},
		ignore_missing = true,
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
		show_help = false,
		triggers = "auto",

		triggers_blacklist = {

			i = { "j", "k" },
			v = { "j", "k" },
		},
	},
	config = function(_, opts)
		local nopts = {
			mode = "n",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		}

		local mappings = {
			["A"] = { "<cmd>Alpha<cr>", "Alpha" },
			["C"] = { "<cmd>:w|%bd|e#<CR>", "Clean Buffers" },
			D = {
				name = "DiffView",
				o = { "<cmd>DiffviewOpen<CR>", "Open" },
				c = { "<cmd>DiffviewClose<CR>", "Close" },
				t = { "<cmd>DiffviewToggleFiles<CR>", "Toggle Files Panel" },
				f = { "<cmd>DiffviewFocusFiles<CR>", "Focus Files Panel" },
				r = { "<cmd>DiffviewRefresh<CR>", "Refresh" },
			},
			p = {
				name = "Packer",
				c = { "<cmd>PackerCompile<cr>", "Compile" },
				i = { "<cmd>PackerInstall<cr>", "Install" },
				s = { "<cmd>PackerSync<cr>", "Sync" },
				S = { "<cmd>PackerStatus<cr>", "Status" },
				u = { "<cmd>PackerUpdate<cr>", "Update" },
			},
			g = {
				name = "Git",
				g = { "<cmd>Neogit<CR>", "Neogit" },
				n = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
				p = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
				l = { "<cmd>Gitsigns blame_line<cr>", "Blame" },
				v = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
				r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
				R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
				s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
				y = { "<cmd>r!curl -s https://whatthecommit.com/index.txt<cr>", "Yolo" },
				k = {
					"<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.copy_to_clipboard})<cr>",
					"Copy URL",
				},
				K = {
					"<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
					"Open URL",
				},
				u = {
					"<cmd>Gitsigns undo_stage_hunk<cr>",
					"Undo Stage Hunk",
				},
				o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
				b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
				d = {
					"<cmd>Gitsigns diffthis HEAD<cr>",
					"Diff",
				},
			},
			S = {
				name = "Session",
				u = { "<cmd>!tmux neww tmux-sessionizer<cr>", "New Tmux" },
				l = { "<cmd>SessionLoad<cr>", "Load" },
				w = { "<cmd>SessionSave<cr>", "Save" },
				p = { "<cmd>SessionStop<cr>", "Stop" },
				s = { "<cmd>SessionStart<cr>", "Start" },
				d = { "<cmd>SessionDelete<cr>", "Delete" },
				t = { "<cmd>SessionToggle<cr>", "Toggle" },
				a = { "<cmd>SessionLoadLast<cr>", "Load Last" },
				f = { "<cmd>SessionLoadFromFile<cr>", "Load From File" },
			},
		}

		local vopts = {
			mode = "v",
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		}

		local vmappings = {
			g = {
				name = "Git",
				k = {
					"<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.copy_to_clipboard})<cr>",
					"Copy URL",
				},
				K = {
					"<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
					"Open URL",
				},
			},
		}

		local wk = require "which-key"

		wk.setup(opts)
		wk.register(mappings, nopts)
		wk.register(vmappings, vopts)
	end,
}

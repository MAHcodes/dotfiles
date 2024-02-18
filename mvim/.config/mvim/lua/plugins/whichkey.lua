return {
	"folke/which-key.nvim",
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
			["b"] = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
			["L"] = { "<cmd>Lf<cr>", "Lf" },
			["C"] = { "<cmd>:w|%bd|e#<CR>", "Clean Buffers" },
			["f"] = {
				"<cmd>lua require('telescope.builtin').find_files()<cr>",
				"Find files",
			},
			["F"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
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
			l = {
				name = "LSP",
				a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
				d = {
					"<cmd>Telescope lsp_document_diagnostics<cr>",
					"Document Diagnostics",
				},
				w = {
					"<cmd>Telescope lsp_workspace_diagnostics<cr>",
					"Workspace Diagnostics",
				},
				f = { "<cmd>lua vim.lsp.buf.format{async = true }<cr>", "Format" },
				i = { "<cmd>LspInfo<cr>", "Info" },
				h = { "<cmd>lua vim.lsp.inlay_hint(0, nil)<cr>", "Inlay Hint" },
				M = { "<cmd>Mason<cr>", "Mason" },
				j = {
					"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
					"Next Diagnostic",
				},
				k = {
					"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
					"Prev Diagnostic",
				},
				l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
				q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
				s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
				S = {
					"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
					"Workspace Symbols",
				},
			},
			s = {
				name = "Search",
				b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				t = { "<cmd>Telescope<cr>", "Telescope" },
				c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
				h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
				M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
				r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
				R = { "<cmd>Telescope registers<cr>", "Registers" },
				k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
				s = { "<cmd>Telescope persisted theme=dropdown<CR>", "Session" },
				C = { "<cmd>Telescope commands<cr>", "Commands" },
				n = { "<cmd>Telescope notify<cr>", "Notify" },
				p = {
					"<cmd>lua require'telescope'.extensions.projects.projects(require('telescope.themes').get_dropdown{previewer= false})<cr>",
					"Projects",
				},
				f = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Find" },
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

		local wk = require("which-key")

		wk.setup(opts)
		wk.register(mappings, nopts)
		wk.register(vmappings, vopts)
	end,
}

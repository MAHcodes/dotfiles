return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			config = function()
				require("ts_context_commentstring").setup {
					enable_autocmd = false,
				}
			end,
		},
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
	},
	opts = {
		on_config_done = nil,
		ensure_installed = "all",
		ignore_install = {},
		parser_install_dir = nil,
		sync_install = false,
		auto_install = true,
		matchup = {
			enable = true,
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
			disable = function(lang, buf)
				if vim.tbl_contains({ "latex" }, lang) then
					return true
				end
				local status_ok, big_file_detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
				return status_ok and big_file_detected
			end,
		},
		indent = { enable = true, disable = { "yaml", "python" } },
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				},
				selection_modes = {
					["@parameter.outer"] = "v",
					["@function.outer"] = "V",
					["@class.outer"] = "<c-v>",
				},
				include_surrounding_whitespace = true,
			},
		},
		textsubjects = {
			enable = false,
			keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
		},
		playground = {
			enable = false,
			disable = {},
			updatetime = 25,
			persist_queries = false,
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}

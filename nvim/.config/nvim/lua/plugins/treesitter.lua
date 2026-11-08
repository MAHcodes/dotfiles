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
		ensure_installed = {},
		auto_install = true,
		highlight = {
			disable = function(lang, buf)
				if vim.tbl_contains({ "latex" }, lang) then
					return true
				end
				local status_ok, big_file_detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
				return status_ok and big_file_detected
			end,
		},
		indent = { disable = { "yaml", "python" } },
		textobjects = {
			select = {
				lookahead = true,
				selection_modes = {
					["@parameter.outer"] = "v",
					["@function.outer"] = "V",
					["@class.outer"] = "<c-v>",
				},
				include_surrounding_whitespace = true,
			},
		},
	},
	config = function(_, opts)
		local ts = require("nvim-treesitter")

		if #opts.ensure_installed > 0 then
			ts.install(opts.ensure_installed)
		end

		local function attach(buf, ft, no_reinstall)
			if not vim.api.nvim_buf_is_valid(buf) then
				return
			end
			local lang = vim.treesitter.language.get_lang(ft) or ft
			if lang == nil or lang == "" then
				return
			end

			-- `auto_install = true`: install missing parsers for supported languages
			-- (note: language.add() returns nil, err instead of throwing in nvim 0.12)
			local ok, added = pcall(vim.treesitter.language.add, lang)
			if not ok or added == nil then
				if not no_reinstall and opts.auto_install and vim.list_contains(ts.get_available(), lang) then
					local task = ts.install({ lang })
					if task and task.await then
						task:await(function()
							vim.schedule(function()
								attach(buf, ft, true)
							end)
						end)
					end
				end
				return
			end

			-- syntax highlighting (disables regex highlighting by default)
			if not opts.highlight.disable(lang, buf) then
				pcall(vim.treesitter.start, buf, lang)
			end

			-- indentation
			if not vim.tbl_contains(opts.indent.disable, lang) then
				vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*",
			callback = function(args)
				attach(args.buf, args.match)
			end,
		})

		-- attach buffers that were open before the plugin loaded
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" then
				attach(buf, vim.bo[buf].filetype)
			end
		end

		-- textobjects
		require("nvim-treesitter-textobjects").setup(opts.textobjects)
		local select = require("nvim-treesitter-textobjects.select")
		vim.keymap.set({ "x", "o" }, "af", function()
			select.select_textobject("@function.outer")
		end, { desc = "Select outer part of a function region" })
		vim.keymap.set({ "x", "o" }, "if", function()
			select.select_textobject("@function.inner")
		end, { desc = "Select inner part of a function region" })
		vim.keymap.set({ "x", "o" }, "ac", function()
			select.select_textobject("@class.outer")
		end, { desc = "Select outer part of a class region" })
		vim.keymap.set({ "x", "o" }, "ic", function()
			select.select_textobject("@class.inner")
		end, { desc = "Select inner part of a class region" })
	end,
}

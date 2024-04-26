return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
  enabled = false,
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
		"nvim-lua/plenary.nvim",
	},
	opts = {
		ensure_installed = nil,
		automatic_installation = true,
	},
	keys = {
		{
			mode = { "n", "v" },
			"<leader>lf",
			function()
				vim.lsp.buf.format { async = true }
			end,
			desc = "Format buffer",
		},
	},
	config = function()
		local nonels = require "null-ls"
		local formatting = nonels.builtins.formatting
		return {
			debug = false,
			sources = {
				-- formatting.prettier,
				-- formatting.prettierd,
				formatting.biome,
				formatting.shfmt,
				formatting.stylua,
				formatting.black,
				formatting.zprint,
			},
		}
	end,
}

return {
	"nvimtools/none-ls.nvim",
  lazy = true,
  event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
    lazy = true,
	},
	opts = function()
		local nonels = require("null-ls")
		local formatting = nonels.builtins.formatting
		return {
			debug = false,
			sources = {
				-- formatting.prettier,
				formatting.prettierd,
				-- formatting.biome,
				formatting.eslint_d.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"css",
						"scss",
						"less",
						"html",
						"json",
						"jsonc",
						"yaml",
						"markdown",
						"markdown.mdx",
						"graphql",
						"handlebars",
						"svelte",
					},
				}),
				formatting.shfmt,
				formatting.stylua,
				formatting.black,
				formatting.zprint,
			},
		}
	end,
}

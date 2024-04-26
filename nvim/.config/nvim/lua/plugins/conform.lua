return {
	"stevearc/conform.nvim",
	enabled = true,
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			mode = { "n", "v" },
			"<leader>lf",
			function()
				require("conform").format { async = true, lsp_fallback = true }
			end,
			desc = "Format buffer",
		},
	},
	opts = {
		format = {
			timeout_ms = 3000,
			async = false,
			quiet = false,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			javascript = { { "biome", "prettierd", "prettier" } },
			typescript = { { "biome", "prettierd", "prettier" } },
			javascriptreact = { { "biome", "prettierd", "prettier" } },
			typescriptreact = { { "biome", "prettierd", "prettier" } },
			vue = { { "prettierd", "prettier" } },
			css = { { "prettierd", "prettier" } },
			scss = { { "prettierd", "prettier" } },
			less = { { "prettierd", "prettier" } },
			html = { { "prettierd", "prettier" } },
			json = { { "prettierd", "prettier" } },
			jsonc = { { "biome", "prettierd", "prettier" } },
			yaml = { { "prettierd", "prettier" } },
			markdown = { { "prettierd", "prettier" } },
			["markdown.mdx"] = { { "prettierd", "prettier" } },
			graphql = { { "prettierd", "prettier" } },
			handlebars = { { "prettierd", "prettier" } },
			sh = { "shfmt" },
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}

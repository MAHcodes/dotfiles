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
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
		lsp_format = "prefer",
		stop_after_first = true,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			javascript = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			javascriptreact = { "prettierd", "prettier" },
			typescriptreact = { "prettierd", "prettier" },
			vue = { "prettierd", "prettier" },
			css = { "prettierd", "prettier" },
			scss = { "prettierd", "prettier" },
			less = { "prettierd", "prettier" },
			html = { "prettierd", "prettier" },
			json = { "jq" },
			jsonc = { "prettierd", "prettier" },
			yaml = { "prettierd", "prettier" },
			markdown = { "prettierd", "prettier" },
			["markdown.mdx"] = { "prettierd", "prettier" },
			graphql = { "prettierd", "prettier" },
			handlebars = { "djlint" },
			sh = { "shfmt" },
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}

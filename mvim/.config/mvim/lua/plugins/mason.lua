return {
	"williamboman/mason.nvim",
  lazy = true,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
    local servers = require("user.servers")

		require("mason").setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = "◍",
					package_pending = "◍",
					package_uninstalled = "◍",
				},
			},
			log_level = vim.log.levels.INFO,
			max_concurrent_installers = 4,
		})

		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_installation = true,
		})
	end,
}

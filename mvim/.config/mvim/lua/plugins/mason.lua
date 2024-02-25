return {
	"williamboman/mason.nvim",
	event = { "BufRead", "BufWinEnter", "BufNewFile" },
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local servers = {
			"cssls",
			"cssmodules_ls",
			"emmet_ls",
			"eslint",
			"html",
			"jsonls",
			"pyright",
			"lua_ls",
			-- "tsserver",
			"vtsls",
			"eslint",
			-- "biome",
			"svelte",
			"tailwindcss",
			"marksman",
			"bashls",
			"gopls",
			"astro",
			"dockerls",
			"docker_compose_language_service",
			"yamlls",
		}

		require("mason").setup {
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
		}

		require("mason-lspconfig").setup {
			ensure_installed = servers,
			automatic_installation = true,
		}

		local lspconfig = require "plugins.lspconfig"
		local opts = {}

		for _, server in pairs(servers) do
			opts = {
				on_attach = lspconfig.on_attach,
				capabilities = lspconfig.common_capabilities(),
			}

			server = vim.split(server, "@")[1]

			local server_opts_ok, server_opts = pcall(require, string.format("user.lspsettings.%s", server))
			if server_opts_ok then
				opts = vim.tbl_deep_extend("force", server_opts, opts)
			end

			require("lspconfig")[server].setup(opts)
		end
	end,
}

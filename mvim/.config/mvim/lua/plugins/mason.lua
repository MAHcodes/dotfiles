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

		local lspconfig = require("plugins.lspconfig")
		local opts = {}

		for _, server in pairs(servers) do
			opts = {
				on_attach = lspconfig.on_attach,
				capabilities = lspconfig.common_capabilities(),
			}

			server = vim.split(server, "@")[1]

			if server == "lua_ls" then
				local sumneko_opts = require("user.lspsettings.lua_ls")
				opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
			end

			if server == "vtsls" then
				local vtsls_opts = require("user.lspsettings.tsserver")
				opts = vim.tbl_deep_extend("force", vtsls_opts, opts)
			end

			if server == "pyright" then
				local pyright_opts = require("user.lspsettings.pyright")
				opts = vim.tbl_deep_extend("force", pyright_opts, opts)
			end

			if server == "emmet_ls" then
				local emmet_ls_opts = require("user.lspsettings.emmet_ls")
				opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
			end

			if server == "astro" then
				local astro_opts = require("user.lspsettings.astro")
				opts = vim.tbl_deep_extend("force", astro_opts, opts)
			end

			if server == "gopls" then
				local gopls_opts = require("user.lspsettings.gopls")
				opts = vim.tbl_deep_extend("force", gopls_opts, opts)
			end

			if server == "tailwindcss" then
				local tailwindcss_opts = require("user.lspsettings.tailwindcss")
				opts = vim.tbl_deep_extend("force", tailwindcss_opts, opts)
			end

			if server == "cssls" then
				local cssls_opts = require("user.lspsettings.cssls")
				opts = vim.tbl_deep_extend("force", cssls_opts, opts)
			end

			if server == "jsonls" then
				local jsonls_opts = require("user.lspsettings.jsonls")
				opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
			end

			if server == "yamlls" then
				local yamlls_opts = require("user.lspsettings.yamlls")
				opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
			end

			require("lspconfig")[server].setup(opts)
		end
	end,
}

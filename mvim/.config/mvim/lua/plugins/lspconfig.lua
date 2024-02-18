local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"SmiteshP/nvim-navic",
			lazy = true,
		},
		{
			"RRethy/vim-illuminate",
			lazy = true,
		},
    {
      "yioneko/nvim-vtsls"
    },
		{
			"b0o/schemastore.nvim",
		},
	},
}

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]])
end

local function lsp_highlight_document(client)
	if client.server_capabilities.document_highlight then
		local illuminate = require("illuminate")
		illuminate.on_attach(client)
	end
end

M.on_attach = function(client, bufnr)
	if client.server_capabilities["documentSymbolProvider"] then
		require("nvim-navic").attach(client, bufnr)
	end
	-- if client.supports_method "textDocument/inlayHint" then
	--   vim.lsp.inlay_hint.enable(bufnr, true)
	-- end

	lsp_highlight_document(client)
	lsp_keymaps(bufnr)
end

function M.common_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	return capabilities
end

M.config = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	local config = {
		virtual_text = false,
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	require("lspconfig.ui.windows").default_options.border = "rounded"

	local servers = require("user.servers")

	local opts = {}

	for _, server in pairs(servers) do
		opts = {
			on_attach = M.on_attach,
			capabilities = M.common_capabilities(),
		}

		server = vim.split(server, "@")[1]

		if server == "lua_ls" then
			local sumneko_opts = require("user.lspsettings.lua_ls")
			opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
		end

		--[[ if server == "tsserver" then
			local tsserver_opts = require("user.lspsettings.tsserver")
			opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
		end ]]

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

		local lspconfig = require("lspconfig")

		lspconfig[server].setup(opts)
	end
end

return M

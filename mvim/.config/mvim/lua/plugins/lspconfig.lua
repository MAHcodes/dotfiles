local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"yioneko/nvim-vtsls",
		"b0o/schemastore.nvim",
		{
			"nvim-telescope/telescope.nvim",
			lazy = true,
		},
		{
			"SmiteshP/nvim-navic",
			lazy = true,
		},
		{
			"RRethy/vim-illuminate",
			lazy = true,
		},
	},
}

local function lsp_keymaps(bufnr)
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
	end

	map("[d", vim.diagnostic.goto_prev, "Goto Prev Diagnostic")
	map("]d", vim.diagnostic.goto_next, "Goto Next Diagnostic")
	map("gl", vim.diagnostic.open_float, "Goto Diagnostic Floating Window")
	map("gq", vim.diagnostic.setloclist, "GoTo diagnostic Quickfix list")

	map("gD", vim.lsp.buf.declaration, "Goto Declaration")
	-- map("K", vim.lsp.buf.hover, "Goto Hover Documentation")
	map("gh", vim.lsp.buf.signature_help, "Goto Signature Documentation")
	map("gn", vim.lsp.buf.rename, "Rename")
	map("ga", vim.lsp.buf.code_action, "Code Action")

	local function ivy(func)
		return function()
			func(require("telescope.themes").get_ivy {
				layout_config = {
					height = vim.o.lines,
				},
			})
		end
	end

	local tb = require "telescope.builtin"
	map("gd", ivy(tb.lsp_definitions), "Goto Definition")
	map("gr", ivy(tb.lsp_references), "Goto References")
	map("gi", ivy(tb.lsp_implementations), "Goto Implementations")
	map("gy", ivy(tb.lsp_type_definitions), "Goto Type Definition")
	map("gs", ivy(tb.lsp_document_symbols), "Goto Document Symbols")
	map("gS", ivy(tb.lsp_dynamic_workspace_symbols), "Goto Workspace Symbols")
	map("go", ivy(tb.diagnostics), "Goto Diagnostics")
end

local function lsp_highlight_document(client)
	if client.server_capabilities.document_highlight then
		local illuminate = require "illuminate"
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
end

return M

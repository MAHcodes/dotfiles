return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"yioneko/nvim-vtsls",
		"b0o/schemastore.nvim",
		"nvim-telescope/telescope.nvim",
		"SmiteshP/nvim-navic",
	},
	config = function()
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
		require("lspconfig.ui.windows").default_options.border = "rounded"

		local signs = {
			{ name = "DiagnosticSignError", text = "" },
			{ name = "DiagnosticSignWarn", text = "" },
			{ name = "DiagnosticSignInfo", text = "" },
			{ name = "DiagnosticSignHint", text = "" },
		}

		for _, sign in ipairs(signs) do
			vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
		end

		vim.diagnostic.config {
			virtual_text = false,
			signs = {
				active = signs,
			},
			update_in_insert = true,
			underline = false,
			severity_sort = true,
			float = {
				focusable = true,
				border = "rounded",
				source = "always",
				header = "",
				prefix = function(diagnostic, i, total)
					local function get_i()
						if total > 1 then
							return " " .. i .. ")"
						end
						return ""
					end

					local get_lnum_range = function()
						if diagnostic.lnum ~= diagnostic.end_lnum then
							return diagnostic.lnum + 1 .. ":" .. diagnostic.end_lnum + 1
						end
						return diagnostic.lnum + 1
					end

					local get_col_range = function()
						if diagnostic.col ~= diagnostic.end_col then
							return diagnostic.col .. ":" .. diagnostic.end_col
						end
						return diagnostic.col
					end

					local sign = signs[diagnostic.severity].text
					local hl = signs[diagnostic.severity].name

					return string.format("%s%s [%s,%s] ", sign, get_i(), get_lnum_range(), get_col_range()), hl
				end,
			},
		}

		local function keymaps(bufnr)
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

			local tb = require "telescope.builtin"
			local theme = require("plugins.telescope").theme

			map("gd", theme(tb.lsp_definitions), "Goto Definition")
			map("gr", theme(tb.lsp_references), "Goto References")
			map("gi", theme(tb.lsp_implementations), "Goto Implementations")
			map("gy", theme(tb.lsp_type_definitions), "Goto Type Definition")
			map("gs", theme(tb.lsp_document_symbols), "Goto Document Symbols")
			map("gS", theme(tb.lsp_dynamic_workspace_symbols), "Goto Workspace Symbols")
		end

		local function highlight_document(client, bufnr)
			if client.server_capabilities.documentHighlightProvider then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = bufnr,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = bufnr,
					callback = vim.lsp.buf.clear_references,
				})
			end
		end

		local function symbols(client, bufnr)
			if client.server_capabilities.documentSymbolProvider then
				require("nvim-navic").attach(client, bufnr)
			end
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(args)
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)

				keymaps(bufnr)
				highlight_document(client, bufnr)
				symbols(client, bufnr)
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

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

		local lsp_servers = {
			"cssls",
			"cssmodules_ls",
			"emmet_ls",
			"eslint",
			"html",
			"jsonls",
			"pyright",
			"lua_ls",
			"vtsls",
			"eslint",
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

		local tools = {
			"stylua",
			"shfmt",
		}

		local ensure_installed = vim.list_extend(lsp_servers, tools)

		require("mason-tool-installer").setup { ensure_installed = ensure_installed }

		require("mason-lspconfig").setup {
			handlers = {
				function(server_name)
					local _, server = pcall(require, string.format("user.lspsettings.%s", server_name))

					require("lspconfig")[server_name].setup {
						cmd = server.cmd,
						settings = server.settings,
						filetypes = server.filetypes,
						capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
					}
				end,
			},
		}
	end,
}

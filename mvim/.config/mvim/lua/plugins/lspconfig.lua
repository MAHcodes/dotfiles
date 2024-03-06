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
			map("gI", theme(tb.lsp_implementations), "Goto Implementations")
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

		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)

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

		local servers = {
			eslint = {},
			html = {},
			pyright = {},
			cssmodules_ls = {},
			svelte = {},
			tailwindcss = {},
			marksman = {},
			bashls = {},
			gopls = {},
			astro = {},
			dockerls = {},
			docker_compose_language_service = {},
			cssls = {
				settings = {
					css = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
				},
			},
			emmet_ls = {
				filetypes = { "html", "css", "typescriptreact", "javascriptreact", "php", "sass", "scss" },
			},
			jsonls = {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			},
			yamlls = {
				settings = {
					yaml = {
						schemaStore = {
							-- You must disable built-in schemaStore support if you want to use
							-- this plugin and its advanced options like `ignore`.
							enable = false,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
							telemetry = {
								enable = false,
							},
						},
					},
				},
			},
			vtsls = {
				settings = {
					typescript = {
						inlayHints = {
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = true },
						},
					},
				},
			},
		}

		vim.list_extend(vim.tbl_keys(servers), {
			"stylua",
			"shfmt",
		})

		require("mason-tool-installer").setup { ensure_installed = servers }

		require("mason-lspconfig").setup {
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})

					require("lspconfig")[server_name].setup(server)
				end,
			},
		}
	end,
}

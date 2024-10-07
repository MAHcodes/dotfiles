return {
	"neovim/nvim-lspconfig",
	event = "UIEnter",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"yioneko/nvim-vtsls",
		"b0o/schemastore.nvim",
		"nvim-telescope/telescope.nvim",
		"SmiteshP/nvim-navic",
		"kevinhwang91/nvim-ufo",
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
				source = true,
				header = "",
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
			map("gw", function()
				vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()), vim.log.levels.INFO, {
					title = "Workspace Folders",
				})
			end, "List Workspace Folders")
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

		local mason_servers = {
			eslint = {},
			djlint = {},
			html = {},
			jqls = {},
			pyright = {},
			cssmodules_ls = {},
			svelte = {},
			tailwindcss = {
				filetypes = {
					"gleam",
					"astro",
					"html",
					"css",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"svelte",
					"templ",
				},
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								'"([^"]*)"',
								[[class= "([^"]*)]],
								[[class: "([^"]*)]],
								'~H""".*class="([^"]*)".*"""',
								'~F""".*class="([^"]*)".*"""',
							},
						},
					},
				},
			},
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
				filetypes = { "html", "css", "typescriptreact", "javascriptreact", "php", "sass", "scss", "gleam" },
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
							enable = false,
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

		local other_servers = {
			"stylua",
			"shfmt",
			"biome",
			"prettier",
			"prettierd",
			"eslint_d",
			"jq",
			"rustywind",
			"xmlformatter",
		}

		local capabilities = vim.tbl_deep_extend(
			"force",
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities(),
			{
				textDocument = {
					foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true,
					},
				},
			}
		)

		local function extend_server_capabilities(server)
			return vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
		end

		local lspconfig = require "lspconfig"
		local configs = require "lspconfig.configs"

		local custom_servers = {
			gleam = {
				cmd = { "gleam", "lsp" },
				-- cmd = { "glas", "--stdio" },
				autostart = true,
				filetypes = { "gleam" },
				root_dir = lspconfig.util.root_pattern("gleam.toml", ".git"),
			},
		}

		for server_name, server_config in pairs(custom_servers) do
			if not configs[server_name] then
				configs[server_name] = {
					default_config = server_config,
				}
				server_config.capabilities = extend_server_capabilities(server_config)
				lspconfig[server_name].setup(server_config)
			end
		end

		local ensure_installed = vim.list_extend(vim.tbl_keys(mason_servers), other_servers)
		require("mason-tool-installer").setup { ensure_installed = ensure_installed }

		require("mason-lspconfig").setup {
			automatic_installation = true,
			handlers = {
				function(server_name)
					local server_config = mason_servers[server_name] or {}
					server_config.capabilities = extend_server_capabilities(server_config)
					lspconfig[server_name].setup(server_config)
				end,
			},
		}
	end,
}

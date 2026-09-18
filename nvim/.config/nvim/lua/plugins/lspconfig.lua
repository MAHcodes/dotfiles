local M = { "neovim/nvim-lspconfig" }

M.event = { "BufReadPre", "BufNewFile" }

M.dependencies = {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"yioneko/nvim-vtsls",
	"b0o/schemastore.nvim",
	"nvim-telescope/telescope.nvim",
	"SmiteshP/nvim-navic",
	"kevinhwang91/nvim-ufo",
}

M.config = function()
	vim.diagnostic.config {
		underline = false,
		virtual_text = false,
		virtual_lines = false,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.INFO] = "",
				[vim.diagnostic.severity.HINT] = "",
			},
		},
		update_in_insert = true,
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

		map("[d", function() vim.diagnostic.jump { count = -1 } end, "Goto Prev Diagnostic")
		map("]d", function() vim.diagnostic.jump { count = 1 } end, "Goto Next Diagnostic")
		map("gl", vim.diagnostic.open_float, "Goto Diagnostic Floating Window")
		map("gq", vim.diagnostic.setloclist, "Goto Diagnostic Quickfix list")

		-- map("K", vim.lsp.buf.hover, "Goto Hover Documentation")
		map("gh", vim.lsp.buf.signature_help, "Goto Signature Documentation")
		map("gn", vim.lsp.buf.rename, "Rename")
		map("ga", vim.lsp.buf.code_action, "Code Action")

		local tb = require "telescope.builtin"

		map("gd", tb.lsp_definitions, "Goto Definition")
		map("gr", tb.lsp_references, "Goto References")
		map("gI", tb.lsp_implementations, "Goto Implementations")
		map("gy", tb.lsp_type_definitions, "Goto Type Definition")
		map("gs", tb.lsp_document_symbols, "Goto Document Symbols")
		map("gS", tb.lsp_dynamic_workspace_symbols, "Goto Workspace Symbols")
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
		"cljfmt",
	}

	-- nvim 0.12+ native LSP: per-server settings are declared with vim.lsp.config()
	-- and servers are enabled with vim.lsp.enable() (mason-lspconfig v2 does this
	-- automatically). The old `handlers`/`automatic_installation` API is removed.
	vim.lsp.config("*", {
		capabilities = {
			textDocument = {
				foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true,
				},
			},
		},
	})

	for server_name, server_config in pairs(mason_servers) do
		if next(server_config) then
			vim.lsp.config(server_name, server_config)
		end
	end

	require("mason-tool-installer").setup { ensure_installed = other_servers }

	require("mason-lspconfig").setup {
		ensure_installed = vim.tbl_keys(mason_servers),
		-- only auto-enable the curated list (default `true` would also enable
		-- every other mason-installed server, e.g. stylua/biome as LSP)
		automatic_enable = vim.tbl_keys(mason_servers),
	}
end

M.whichkey = { "<leader>s", group = "Search" }

return M

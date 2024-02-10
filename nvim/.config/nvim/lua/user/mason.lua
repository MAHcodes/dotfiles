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

local settings = {
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

require("mason").setup(settings)
require("mason-lspconfig").setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  if server == "lua_ls" then
    local sumneko_opts = require "user.lsp.settings.lua_ls"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  --[[ if server == "tsserver" then
    local tsserver_opts = require "user.lsp.settings.tsserver"
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end ]]

  if server == "vtsls" then
    local vtsls_opts = require "user.lsp.settings.tsserver"
    opts = vim.tbl_deep_extend("force", vtsls_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "emmet_ls" then
    local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  if server == "astro" then
    local astro_opts = require "user.lsp.settings.astro"
    opts = vim.tbl_deep_extend("force", astro_opts, opts)
  end

  if server == "gopls" then
    local gopls_opts = require "user.lsp.settings.gopls"
    opts = vim.tbl_deep_extend("force", gopls_opts, opts)
  end

  if server == "tailwindcss" then
    local tailwindcss_opts = require "user.lsp.settings.tailwindcss"
    opts = vim.tbl_deep_extend("force", tailwindcss_opts, opts)
  end

  if server == "cssls" then
    local cssls_opts = require "user.lsp.settings.cssls"
    opts = vim.tbl_deep_extend("force", cssls_opts, opts)
  end

  if server == "jsonls" then
    local jsonls_opts = require "user.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "yamlls" then
    local yamlls_opts = require "user.lsp.settings.yamlls"
    opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
  end

  lspconfig[server].setup(opts)
end

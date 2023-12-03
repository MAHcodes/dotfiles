local status_ok, vtsls = pcall(require, "vtsls")
if not status_ok then
  return
end

vtsls.config({
  -- customize handlers for commands
  handlers = {
    source_definition = function(err, locations) end,
    file_references = function(err, locations) end,
    code_action = function(err, actions) end,
  },
  -- automatically trigger renaming of extracted symbol
  refactor_auto_rename = true,
})

require("lspconfig.configs").vtsls = require("vtsls").lspconfig

local tsserver_opts = require "user.lsp.settings.tsserver"

require("lspconfig").vtsls.setup(tsserver_opts)

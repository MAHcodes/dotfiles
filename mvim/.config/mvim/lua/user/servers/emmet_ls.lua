local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  capabilities = capabilities,

  -- supported filetypes: html, pug, typescriptreact, javascript, javascriptreact, svelte, vue, css, sass, scss and less
  filetypes = { "html", "css", "typescriptreact", "javascriptreact", "php", "sass", "scss" },
  autostart = true,
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  }
}

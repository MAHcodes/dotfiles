return {
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      completion = {
        callSnippet = "Replace"
      },
      diagnostics = {
        globals = { "vim", "spec" },
      },
      runtime = {
        version = "LuaJIT",
        special = {
          spec = "require",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
      hint = { enable = true },
      telemetry = {
        enable = false,
      },
    },
  },
}

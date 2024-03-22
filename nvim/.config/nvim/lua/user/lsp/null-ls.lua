local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting

null_ls.setup {
  debug = false,
  sources = {
    -- formatting.prettier,
    formatting.prettierd,
    -- formatting.biome,
    formatting.shfmt,
    formatting.stylua,
    formatting.black,
    formatting.zprint,
  },
}

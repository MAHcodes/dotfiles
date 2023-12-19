local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
local actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup {
  debug = false,
  sources = {
    -- formatting.prettier,
    formatting.prettierd,
    -- formatting.biome,
    -- formatting.eslint_d,
    formatting.shfmt,
    formatting.black,
    -- actions.eslint,
    actions.eslint_d,
    diagnostics.gitlint,
  },
}

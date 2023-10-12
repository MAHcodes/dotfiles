local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end


local dap_mappings = {
  m = {
    name = "Lang Specific",
    r = { ":!go run %<CR>", "Run" },
    t = { ":!go mod tidy<CR>", "Tidy" },
  }
}

local opts = {
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

which_key.register(dap_mappings, { mode = "n", opts })
which_key.register(
  {
    m = {
      name = "Lang Specific",
      g = { ":!gojsonstruct<CR>", "gojsonstruct" },
    }
  }, { mode = "v", opts })

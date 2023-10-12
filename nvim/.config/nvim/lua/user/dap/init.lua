local status_ok, _ = pcall(require, "dap")
if not status_ok then
  return
end

local colors = require("catppuccin.palettes").get_palette "mocha"

-- vim.keymap.set("n", "<leader>dlp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")

vim.api.nvim_set_hl(0, "red_breakpoint",   { fg = colors.red })
vim.api.nvim_set_hl(0, "blue_breakpoint",   { fg = colors.blue })
vim.api.nvim_set_hl(0, "green_breakpoint",  { fg = colors.green})
vim.api.nvim_set_hl(0, "yellow_breakpoint", { fg = colors.yellow })
vim.api.nvim_set_hl(0, "orange_breakpoint", { fg = colors.peach })

vim.fn.sign_define('DapBreakpoint',          { text='', texthl='red_breakpoint',   linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='blue_breakpoint',   linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected',  { text='', texthl='orange_breakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapStopped',             { text='', texthl='green_breakpoint',  linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapLogPoint',            { text='', texthl='yellow_breakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })

local which_key_status_ok, which_key = pcall(require, "which-key")
if not which_key_status_ok then
  return
end

local dap_mappings = {
  d = {
    name = "Debug",
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    B = { ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "Breakpoint condition" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
    s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
    q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
    U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
  }
}

local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

which_key.register(dap_mappings, opts)

require "user.dap.virtual-text"
require "user.dap.dapui"
require "user.dap.go"

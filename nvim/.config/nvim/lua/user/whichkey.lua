local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>",   -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded",       -- none, single, double, shadow
    position = "bottom",      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
    padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 5, max = 25 },                                             -- min and max height of the columns
    width = { min = 20, max = 50 },                                             -- min and max width of the columns
    spacing = 4,                                                                -- spacing between columns
    align = "center",                                                           -- align columns left, center or right
  },
  ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = false,                                                            -- show help message on the command line when the popup is visible
  triggers = "auto",                                                            -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
  ["A"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer= false, initial_mode = 'normal'})<cr>",
    "Buffers",
  },
  ["L"] = { "<cmd>Lf<cr>", "Lf" },
  ["C"] = { "<cmd>:w|%bd|e#<CR>", "Clean Buffers" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files()<cr>",
    "Find files",
  },
  ["F"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
  t = TextCaseWhichKey,
  h = {
    name = "Harpoon",
    u = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "Harpoon UI" },
    a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add file" },
    n = { "<cmd>lua require('harpoon.ui').nav_next()<cr>", "Next file" },
    p = { "<cmd>lua require('harpoon.ui').nav_prev()<cr>", "Prev file" },
    ["1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Nav to file 1" },
    ["2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Nav to file 2" },
    ["3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Nav to file 3" },
    ["4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "Nav to file 4" },
    ["5"] = { "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", "Nav to file 5" },
  },
  D = {
    name = "DiffView",
    o = { "<cmd>DiffviewOpen<CR>", "Open" },
    c = { "<cmd>DiffviewClose<CR>", "Close" },
    t = { "<cmd>DiffviewToggleFiles<CR>", "Toggle Files Panel" },
    f = { "<cmd>DiffviewFocusFiles<CR>", "Focus Files Panel" },
    r = { "<cmd>DiffviewRefresh<CR>", "Refresh" },
  },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  g = {
    name = "Git",
    a = { "<cmd>GitCoAuthors<CR>", "CoAuthors" },
    g = { "<cmd>Neogit<CR>", "Neogit" },
    n = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
    p = { "<cmd>Gitsigns prev_hunk<cr>", "Prev Hunk" },
    l = { "<cmd>Gitsigns blame_line<cr>", "Blame" },
    v = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
    R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
    s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
    y = { "<cmd>r!curl -s https://whatthecommit.com/index.txt<cr>", "Yolo" },
    k = {
      "<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.copy_to_clipboard})<cr>",
      "Copy URL" },
    K = {
      "<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
      "Open URL" },
    u = {
      "<cmd>Gitsigns undo_stage_hunk<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },
  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.format{async = true }<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    h = { "<cmd>lua vim.lsp.inlay_hint(0, nil)<cr>", "Inlay Hint" },
    M = { "<cmd>Mason<cr>", "Mason" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    t = { "<cmd>Telescope<cr>", "Telescope" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    s = { "<cmd>Telescope persisted theme=dropdown<CR>", "Session" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    n = { "<cmd>Telescope notify<cr>", "Notify" },
    p = {
      "<cmd>lua require'telescope'.extensions.projects.projects(require('telescope.themes').get_dropdown{previewer= false})<cr>",
      "Projects" },
    f = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Find" },
  },
  S = {
    name = "Session",
    u = { "<cmd>!tmux neww tmux-sessionizer<cr>", "New Tmux" },
    l = { "<cmd>SessionLoad<cr>", "Load" },
    w = { "<cmd>SessionSave<cr>", "Save" },
    p = { "<cmd>SessionStop<cr>", "Stop" },
    s = { "<cmd>SessionStart<cr>", "Start" },
    d = { "<cmd>SessionDelete<cr>", "Delete" },
    t = { "<cmd>SessionToggle<cr>", "Toggle" },
    a = { "<cmd>SessionLoadLast<cr>", "Load Last" },
    f = { "<cmd>SessionLoadFromFile<cr>", "Load From File" },
  },
}

local vopts = {
  mode = "v",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local vmappings = {
  g = {
    name = "Git",
    k = {
      "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.copy_to_clipboard})<cr>",
      "Copy URL" },
    K = {
      "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
      "Open URL" },
  },
  t = TextCaseWhichKey,
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)

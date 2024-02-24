local opts = { noremap = true, silent = true }

-- Shorten function name
-- local keymap = vim.keymap.set
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Navigate tabs
-- keymap("n", "<M-h>", ":tabm -1<CR>", opts)
-- keymap("n", "<M-l>", ":tabm +1<CR>", opts)

-- tmux-like keymaps
keymap("n", '<Leader>"', ":split<CR>", opts)
keymap("n", "<Leader>%", ":vsplit<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- preserve paste over
keymap("x", "<Leader>p", '"_dP', opts)

-- Other
-- keep cursor centered
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-f>", "<C-f>zz", opts)
keymap("n", "<C-b>", "<C-b>zz", opts)
keymap("n", "J", "mzJ`z", opts)

-- prevent registry overwrite
keymap("x", "p", [["_dP]], opts)

-- toggle wrap
keymap("n", "<A-z>", ":set wrap!<CR>", opts)

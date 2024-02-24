-- remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

-- tmux-like keymaps
keymap("n", '<Leader>"', ":split<CR>", { desc = "Split Window Horizantally", silent = true })
keymap("n", "<Leader>%", ":vsplit<CR>", { desc = "Split Window Vertically", silent = true })

-- stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- preserve paste over
keymap("x", "<Leader>p", '"_dP', { desc = "Preserve Paste Over" })

-- keep cursor centered
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap("n", "*", "*zz")
keymap("n", "#", "#zz")
keymap("n", "g*", "g*zz")
keymap("n", "g#", "g#zz")
keymap("n", "J", "mzJ`z")

-- prevent registry overwrite
keymap("x", "p", [["_dP]])

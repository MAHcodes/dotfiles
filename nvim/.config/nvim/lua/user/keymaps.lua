-- remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- keep cursor centered
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")
map("n", "g*", "g*zz")
map("n", "g#", "g#zz")
map("n", "J", "mzJ`z")

-- prevent registry overwrite
map("x", "p", [["_dP]])

map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("x", "<Leader>p", '"_dP', { desc = "Preserve Paste Over" })

-- tmux-like keymaps
map("n", '<Leader>"', ":split<CR>", { desc = "Split Window Horizantally", silent = true })
map("n", "<Leader>%", ":vsplit<CR>", { desc = "Split Window Vertically", silent = true })

-- remove default commands
map("i", "<C-p>", "<NOP>")
map("i", "<C-n>", "<NOP>")
map("n", "<C-z>", "<NOP>")

-- git
map("n", "<leader>gy", "<cmd>r!curl -s https://whatthecommit.com/index.txt<cr>", { desc = "Git Yolo" })

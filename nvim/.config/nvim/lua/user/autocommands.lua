-- Helper function to create autocommands
local function create_autocmd(event, pattern, callback)
  vim.api.nvim_create_autocmd(event, {
    pattern = pattern,
    callback = callback
  })
end

-- _general_settings
create_autocmd('FileType', 'qf,help,man,lspinfo', function()
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':close<CR>', { silent = true, noremap = true })
end)

create_autocmd('TextYankPost', '*', function()
  require('vim.highlight').on_yank({ higroup = 'Search', timeout = 20 })
end)

create_autocmd('BufWinEnter', '*', function()
  vim.cmd('set formatoptions-=cro')
end)

create_autocmd('FileType', 'qf', function()
  vim.cmd('set nobuflisted')
end)

-- _git
create_autocmd('FileType', 'gitcommit', function()
  vim.cmd('setlocal wrap')
  vim.cmd('setlocal spell')
end)

-- _markdown
create_autocmd('FileType', 'markdown', function()
  vim.cmd('setlocal wrap')
  vim.cmd('setlocal spell')
end)

-- _auto_resize
create_autocmd('VimResized', '*', function()
  vim.cmd('tabdo wincmd =')
end)

-- _tmux
create_autocmd('BufRead,BufNewFile', '*.tmux', function()
  vim.cmd('set filetype=tmux')
end)

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    local mocha = require("catppuccin.palettes").get_palette "mocha"
    vim.api.nvim_set_hl(0, "ICursor", { bg = mocha.green })
    vim.api.nvim_set_hl(0, "VCursor", { bg = mocha.mauve })
    vim.api.nvim_set_hl(0, "RCursor", { bg = mocha.red })
    vim.api.nvim_set_hl(0, "NoiceCursor", { bg = mocha.peach })
    vim.opt.guicursor = 'n:block,ci:block-NoiceCursor,v:block-VCursor,i-ci-ve:block-ICursor,r-cr-o:block-RCursor'
  end
})

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end

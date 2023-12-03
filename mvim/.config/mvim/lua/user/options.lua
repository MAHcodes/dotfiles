local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  completeopt = { "menuone", "noselect" },
  conceallevel = 2,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  mouse = "",
  pumheight = 10,
  showmode = false,
  showtabline = 1,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  -- guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
  timeoutlen = 1000,
  undofile = true,
  updatetime = 50,
  writebackup = false,
  expandtab = true,
  shiftwidth = 0,
  tabstop = 2,
  cursorline = true,
  cursorcolumn = false,
  number = true,
  relativenumber = true,
  numberwidth = 1,
  signcolumn = "yes",
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  list = true,
  spell = true,
  confirm = true,
  spelllang = { 'en_us' },
  background = "dark",
  listchars = { trail = "·", eol = "$", extends = ">", precedes = "<", tab = "→ ", nbsp = "␣" },
}

vim.opt.shortmess:append "cos"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.api.nvim_set_var("t_ZH", "[3m")
vim.api.nvim_set_var("t_ZR", "[23m")
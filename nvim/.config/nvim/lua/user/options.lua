local options = {
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 1,
	completeopt = { "menuone", "noselect" },
	conceallevel = 2,
	fileencoding = "utf-8",
	hlsearch = true,
	ignorecase = true, -- \C to prevent this option
	mouse = "",
	pumheight = 10,
	showmode = false,
	showtabline = 1,
	breakindent = true,
	smartcase = true,
	smartindent = true,
	inccommand = "split",
	splitbelow = true,
	splitright = true,
	swapfile = false,
	termguicolors = true,
	timeoutlen = 1000,
	undofile = true,
	updatetime = 250,
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
	confirm = true,
	spell = false,
	spelllang = { "en_us" },
	list = true,
	termbidi = true,
	textwidth = 65,
	ai = true,
	listchars = {
		trail = "·",
		eol = "$",
		extends = "",
		precedes = "",
		nbsp = "␣",
		tab = "» ",
	},
	fillchars = { diff = " " },
}

-- vim.opt.shortmess:append "cos"

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.api.nvim_set_var("t_ZH", "[3m")
vim.api.nvim_set_var("t_ZR", "[23m")

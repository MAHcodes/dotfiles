vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.fo:append { "r", "c" }
		vim.opt.fo:remove "o"
		vim.opt.fo:remove "t"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf", "help", "notify" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close<CR>")
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		return vim.highlight.on_yank {
			timeout = 100,
			higroup = "lualine_a_normal",
			on_macro = true,
		}
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	command = "set nobuflisted",
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.mdx",
	command = "set ft=jsx",
})

vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	command = "tabdo wincmd =",
})

vim.api.nvim_create_autocmd({ "BufEnter", "ColorScheme" }, {
	pattern = "*",
	group = vim.api.nvim_create_augroup("colored-guicursor", { clear = true }),
	callback = function()
		local h = vim.api.nvim_set_hl
		h(0, "NCursor", { link = "lualine_a_normal" })
		h(0, "ICursor", { link = "lualine_a_insert" })
		h(0, "VCursor", { link = "lualine_a_visual" })
		h(0, "RCursor", { link = "lualine_a_replace" })
		h(0, "NoiceCursor", { link = "lualine_a_command" })
		vim.opt.guicursor = "n:block-NCursor,ci:block-NoiceCursor,v:block-VCursor,i-ve:block-ICursor,r-cr-o:block-RCursor"
	end,
})

-- helper function
local function create_autocmd(event, pattern, callback)
	vim.api.nvim_create_autocmd(event, {
		pattern = pattern,
		callback = callback,
	})
end

create_autocmd("FileType", { "qf", "help", "notify" }, function()
	vim.keymap.set("n", "q", "<cmd>close<CR>")
end)

create_autocmd("TextYankPost", "*", function()
	return vim.highlight.on_yank { timeout = 100 }
end)

create_autocmd("FileType", "qf", function()
	vim.cmd "set nobuflisted"
end)

-- fix mdx highlight
create_autocmd({ "BufEnter" }, "*.mdx", function()
	vim.cmd "set ft=jsx"
end)

-- auto resize
create_autocmd("VimResized", "*", function()
	vim.cmd "tabdo wincmd ="
end)

create_autocmd({ "VimEnter", "ColorScheme" }, "*", function()
	vim.api.nvim_set_hl(0, "NCursor", { link = "lualine_a_normal" })
	vim.api.nvim_set_hl(0, "ICursor", { link = "lualine_a_insert" })
	vim.api.nvim_set_hl(0, "VCursor", { link = "lualine_a_visual" })
	vim.api.nvim_set_hl(0, "RCursor", { link = "lualine_a_replace" })
	vim.api.nvim_set_hl(0, "NoiceCursor", { link = "lualine_a_command" })
	vim.opt.guicursor = "n:block-NCursor,ci:block-NoiceCursor,v:block-VCursor,i-ve:block-ICursor,r-cr-o:block-RCursor"
end)

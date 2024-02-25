-- helper function
local function create_autocmd(event, pattern, callback)
	vim.api.nvim_create_autocmd(event, {
		pattern = pattern,
		callback = callback,
	})
end

create_autocmd("FileType", { "qf", "help" }, function()
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

create_autocmd("VimEnter", "*", function()
	local mocha = require("catppuccin.palettes").get_palette "mocha"
	vim.api.nvim_set_hl(0, "ICursor", { bg = mocha.green })
	vim.api.nvim_set_hl(0, "VCursor", { bg = mocha.mauve })
	vim.api.nvim_set_hl(0, "RCursor", { bg = mocha.red })
	vim.api.nvim_set_hl(0, "NoiceCursor", { bg = mocha.peach })
	vim.opt.guicursor = "n:block,ci:block-NoiceCursor,v:block-VCursor,i-ci-ve:block-ICursor,r-cr-o:block-RCursor"
end)

-- fix luasnip tab weird behavior
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		local status_ok, luasnip = pcall(require, "luasnip")
		if not status_ok then
			return
		end
		if luasnip.expand_or_jumpable() then
			-- ask maintainer for option to make this silent
			-- luasnip.unlink_current()
			vim.cmd [[silent! lua require("luasnip").unlink_current()]]
		end
	end,
})

local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

autocmd("FileType", {
	group = augroup "formatoptions",
	pattern = "*",
	callback = function()
		vim.opt.fo:append { "r" }
		vim.opt.fo:remove { "o" }
	end,
})

autocmd("FileType", {
	group = augroup "close_with_q",
	pattern = { "qf", "help", "notify", "man", "lspinfo", "checkhealth" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close<CR>", {
			buffer = true,
			nowait = true,
			silent = true,
			desc = "Close window",
		})
	end,
})

autocmd("TextYankPost", {
	group = augroup "hi_yank",
	pattern = "*",
	callback = function()
		return vim.highlight.on_yank {
			timeout = 100,
			higroup = "lualine_a_normal",
			on_macro = true,
			on_visual = true,
		}
	end,
})

autocmd("BufEnter", {
	pattern = "*.mdx",
	callback = function()
		vim.bo.filetype = "jsx"
	end,
})

autocmd("VimResized", {
	group = augroup "equal-splits",
	pattern = "*",
	callback = function()
		vim.cmd.wincmd "="
	end,
})

autocmd({ "BufEnter", "ColorScheme" }, {
	group = augroup "colored-guicursor",
	pattern = "*",
	callback = function()
		local highlights = {
			{ name = "NCursor", link = "lualine_a_normal" },
			{ name = "ICursor", link = "lualine_a_insert" },
			{ name = "VCursor", link = "lualine_a_visual" },
			{ name = "RCursor", link = "lualine_a_replace" },
			{ name = "NoiceCursor", link = "lualine_a_command" },
		}

		for _, hl in ipairs(highlights) do
			vim.api.nvim_set_hl(0, hl.name, { link = hl.link })
		end

		vim.opt.guicursor = {
			"n:block-NCursor",
			"ci:block-NoiceCursor",
			"v:block-VCursor",
			"i-ve:block-ICursor",
			"r-cr-o:block-RCursor",
		}
	end,
})

local cursor_group = augroup "cursor-line"

autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
	group = cursor_group,
	pattern = "*",
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
	group = cursor_group,
	pattern = "*",
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

autocmd({ "BufWritePre" }, {
	group = augroup "auto_create_dir",
	callback = function(event)
		if event.match:match "^%w%w+:[\\/][\\/]" then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

autocmd("FileType", {
	group = augroup "toggletodo",
	pattern = "markdown",
	callback = function()
		vim.keymap.set("n", "<leader>x", function()
			local line = vim.api.nvim_get_current_line()
			if line:match "^%s*[*+-]%s%[%s%]" then
				line = line:gsub("^(%s*[*+-]%s)%[%s%]", "%1[x]")
			elseif line:match "^%s*[*+-]%s%[x%]" then
				line = line:gsub("^(%s*[*+-]%s)%[x%]", "%1[ ]")
			end
			vim.api.nvim_set_current_line(line)
		end, {
			buffer = true,
			nowait = true,
			silent = true,
			desc = "Toggle Todo",
		})
	end,
})

--[[ autocmd("FileType", {
	group = augroup("detect-ft"),
	pattern = "*",
	callback = function()
		local ft = vim.bo.filetype
		if not string.match(ft, "notify") then
			print("window filetype: " .. ft)
		end
	end,
}) ]]

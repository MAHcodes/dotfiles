local function toggletodo()
	-- Get current line
	local line = vim.api.nvim_get_current_line()

	-- Check if line contains a todo item and toggle it
	if line:match "^%s*[*+-]%s%[%s%]" then
		-- Change [ ] to [x]
		line = line:gsub("^(%s*[*+-]%s)%[%s%]", "%1[x]")
	elseif line:match "^%s*[*+-]%s%[x%]" then
		-- Change [x] to [ ]
		line = line:gsub("^(%s*[*+-]%s)%[x%]", "%1[ ]")
	end

	-- Update the line
	vim.api.nvim_set_current_line(line)
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.keymap.set("n", "<leader>x", toggletodo, { buffer = true, desc = "Toggle Todo" })
	end,
})

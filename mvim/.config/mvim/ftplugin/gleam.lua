vim.lsp.start {
	name = "gleam",
	-- cmd = { "gleam", "lsp" },
	cmd = { "glas", "--stdio" },
	autostart = true,
	filetypes = { "gleam" },
	root_dir = vim.fs.dirname(vim.fs.find({ "gleam.toml", ".git" }, { upward = true })[1]),
}

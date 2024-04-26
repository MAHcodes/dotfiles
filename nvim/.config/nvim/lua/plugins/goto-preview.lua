return {
	"rmagatti/goto-preview",
	keys = {
		{ "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "Preview Definition" },
		{ "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "Close Preview" },
		{ "go", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", desc = "Preview Reference" },
	},
	opts = {
		height = 25,
		default_mappings = false,
		border = { "↖", "─", "╮", "│", "╯", "─", "╰", "│" },
	},
}

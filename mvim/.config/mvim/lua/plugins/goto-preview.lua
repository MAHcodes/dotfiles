return {
	"rmagatti/goto-preview",
	keys = {
		{ "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", noremap = true },
		{ "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", noremap = true },
		{ "go", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", noremap = true },
	},
	opts = {
		height = 25,
		default_mappings = false,
	},
}

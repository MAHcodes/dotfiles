local opts = {
	nowait = true,
	noremap = true,
}

return {
	"rmagatti/goto-preview",
	keys = {
		{ "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", opts },
		{ "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", opts },
		{ "go", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", opts },
	},
	opts = {
		height = 25,
		default_mappings = false,
    border = {"↖", "─" ,"╮", "│", "╯", "─", "╰", "│"};
	},
}

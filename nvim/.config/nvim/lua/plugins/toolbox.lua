return {
	"DanWlker/toolbox.nvim",
	lazy = true,
	keys = {
		{
			"<leader>st",
			"<CMD>lua require('toolbox').show_picker()<CR>",
			desc = "Search Toolbox",
		},
	},
	opts = {
		commands = {
			{
				name = "Format Json",
				execute = "%!jq '.'",
				require_input = true,
			},
		},
	},
}

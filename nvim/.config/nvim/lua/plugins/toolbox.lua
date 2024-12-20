return {
	"DanWlker/toolbox.nvim",
	lazy = true,
	keys = {
		{
			"<leader>sx",
			function()
				require("toolbox").show_picker()
			end,
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

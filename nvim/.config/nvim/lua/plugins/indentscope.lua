return {
	"echasnovski/mini.indentscope",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		draw = {
			delay = 100,
			animation = function()
				return 20
			end,
		},
		symbol = "│",
	},
}

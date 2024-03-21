return {
	"shellRaining/hlchunk.nvim",
  enabled = false,
	event = { "UIEnter" },
	opts = {
		chunk = {
			chars = {
				right_arrow = "─",
			},
			style = {
				{ link = "Whitespace" },
				{ link = "Error" },
			},
		},
		indent = {
			enable = false,
		},
		line_num = {
			enable = false,
		},
		blank = {
			enable = false,
		},
	},
}

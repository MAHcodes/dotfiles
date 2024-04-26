return {
	"lukas-reineke/indent-blankline.nvim",
	enabled = false,
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		indent = {
			char = "▏",
			tab_char = "▏",
		},
		scope = {
			show_start = false,
			show_end = false,
		},
	},
}

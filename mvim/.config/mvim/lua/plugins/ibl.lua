return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	lazy = true,
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

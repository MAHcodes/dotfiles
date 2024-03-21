return {
	"chrishrb/gx.nvim",
	keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
	cmd = { "Browse" },
	dependencies = { "nvim-lua/plenary.nvim" },
	init = function()
		vim.g.netrw_nogx = 1 -- disable netrw gx
	end,
	config = true,
	submodules = false,
}

return {
	"gmr458/cold.nvim",
	lazy = true,
	priority = 1000,
	config = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "cold",
			group = vim.api.nvim_create_augroup("cold-colorscheme-custom-hl", { clear = true }),
			callback = function()
				local h = vim.api.nvim_set_hl
				local palette = require "cold.palette"

				-- alpha
				h(0, "AlphaHeader", { fg = palette.green_05 })
				h(0, "AlphaButtons", { fg = palette.light_01 })
				h(0, "AlphaShortcut", { fg = palette.grey_02, italic = true })
				h(0, "AlphaFooter", { fg = palette.blue_03, bold = true })
			end,
		})

		vim.cmd.colorscheme "cold"
	end,
}

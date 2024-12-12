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
				h(0, "@alpha.header", { fg = palette.green_05 })
				h(0, "@alpha.text", { fg = palette.light_01 })
				h(0, "@alpha.shortcut", { fg = palette.grey_02, italic = true })
				h(0, "@alpha.footer", { fg = palette.blue_03, bold = true })
			end,
		})

		vim.cmd.colorscheme "cold"
	end,
}

return {
	"duxlabs-dev/base46",
	lazy = false,
	priority = 1000,
	opts = {
		hl_add = {
			AlphaShortcut = { fg = "red", italic = true },
			AlphaFooter = { fg = "orange", bold = true },
		},
		hl_override = {
			AlphaHeader = { fg = "green" },
			AlphaButtons = { fg = "blue" },
		},
	},
	config = function(_, opts)
		require("base46").setup(opts)
		-- DMS (dux-shell) generates ~/.config/nvim/colors/dms.lua from the
		-- current system theme; use it when available, else fall back.
		if vim.uv.fs_stat(vim.fn.stdpath "config" .. "/colors/dms.lua") then
			vim.cmd.colorscheme "dms"
		else
			vim.cmd.colorscheme "base46-gruvchad"
		end
	end,
}

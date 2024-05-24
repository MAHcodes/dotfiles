return {
	"johmsalas/text-case.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	keys = {
		{ "gC", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Text Case" },
	},
	cmd = {
		"TextCaseOpenTelescope",
		"TextCaseOpenTelescopeQuickChange",
		"TextCaseOpenTelescopeLSPChange",
		"TextCaseStartReplacingCommand",
	},
	opts = {
		default_keymappings_enabled = false,
	},
	config = function(_, opts)
		require("textcase").setup(opts)
		require("telescope").load_extension "textcase"
	end,
}

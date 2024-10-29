return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		stages = "fade_in_slide_out",
		on_open = nil,
		on_close = nil,
		render = "compact",
		timeout = 175,
		-- background_colour = "#000000",
		minimum_width = 10,
		top_down = true,
		level = 2,
		icons = {
			ERROR = "",
			WARN = "",
			INFO = "",
			DEBUG = "",
			TRACE = "",
		},
	},
	config = function(_, opts)
		local notify = require "notify"
		notify.setup(opts)
		vim.notify = notify

		require("telescope").load_extension "notify"
	end,
}

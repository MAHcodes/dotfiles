return {
	"toppair/peek.nvim",
	cmd = { "PeekOpen" },
	build = "deno task --quiet build:fast",
	opts = {
		auto_load = true,
		close_on_bdelete = true,
		update_on_change = true,
		app = "browser",
	},
	config = function(_, opts)
		require("peek").setup(opts)
		vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
		vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
	end,
}

return {
	"rest-nvim/rest.nvim",
	ft = "http",
	keys = function()
		return {
			{ "<leader>rr", "<cmd>Rest run<CR>", desc = "Rest run" },
			{ "<leader>rl", "<cmd>Rest last<CR>", desc = "Rest last" },
			{ "<leader>rg", "<cmd>Rest logs<CR>", desc = "Rest logs" },
			{ "<leader>re", "<cmd>Rest env<CR>", desc = "Rest env" },
			{ "<leader>rs", "<cmd>Rest env select<CR>", desc = "Rest env select" },
			{ "<leader>ro", "<cmd>Rest open<CR>", desc = "Rest open" },
			{ "<leader>rc", "<cmd>Rest cookies<CR>", desc = "Rest cookies" },
		}
	end,
}

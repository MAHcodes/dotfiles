return {
	"numToStr/Comment.nvim",
	event = { "BufRead", "BufWinEnter", "BufNewFile" },
	opts = {
		pre_hook = function(...)
			local loaded, ts_comment = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
			if loaded and ts_comment then
				return ts_comment.create_pre_hook()(...)
			end
		end,
	},
}

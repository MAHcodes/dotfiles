return {
	"numToStr/Comment.nvim",
	keys = {
		{ "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
		{ "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
	},
	opts = {
		pre_hook = function(...)
			local loaded, ts_comment = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
			if loaded and ts_comment then
				return ts_comment.create_pre_hook()(...)
			end
		end,
	},
}

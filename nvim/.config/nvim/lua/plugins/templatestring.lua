return {
	"axelvc/template-string.nvim",
	event = "InsertEnter",
	ft = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "vue", "svelte", "python" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
	},
	config = true,
}

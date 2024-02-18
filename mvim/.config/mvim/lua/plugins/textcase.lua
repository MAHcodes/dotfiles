return {
	"johmsalas/text-case.nvim",
	event = "VeryLazy",
	config = function()
		require("textcase").setup()
		local wk = require("which-key")
		local mappings = {
			t = {
				name = "Text Case",
				u = { "<cmd>lua require('textcase').operator('to_upper_case')<CR>", "To Upper Case" },
				l = { "<cmd>lua require('textcase').operator('to_lower_case')<CR>", "To Lower Case" },
				k = { "<cmd>lua require('textcase').operator('to_snake_case')<CR>", "To Snake Case" },
				d = { "<cmd>lua require('textcase').operator('to_dash_case')<CR>", "To Dash Case" },
				n = { "<cmd>lua require('textcase').operator('to_constant_case')<CR>", "To Constant Case" },
				o = { "<cmd>lua require('textcase').operator('to_dot_case')<CR>", "To Dot Case" },
				h = { "<cmd>lua require('textcase').operator('to_phrase_case')<CR>", "To Phrase Case" },
				c = { "<cmd>lua require('textcase').operator('to_camel_case')<CR>", "To Camel Case" },
				s = { "<cmd>lua require('textcase').operator('to_pascal_case')<CR>", "To Pascal Case" },
				t = { "<cmd>lua require('textcase').operator('to_title_case')<CR>", "To Title Case" },
				a = { "<cmd>lua require('textcase').operator('to_path_case')<CR>", "To Path Case" },
			},
		}
		local opts = {
			mode = { "n", "v" },
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		}

		wk.register(mappings, opts)
	end,
}

return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		{
			"kevinhwang91/promise-async",
      lazy = true,
		},
		{
			"luukvbaal/statuscol.nvim",
			opts = function()
				local builtin = require("statuscol.builtin")
				return {
					setopt = true,
					relculright = true,
					segments = {
						{ text = { "%s" }, click = "v:lua.ScSa" },
						{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa", hl = "Normal" },
					},
				}
			end,
		},
	},
	opts = function()
		local handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local suffix = (" 󰡏 %d "):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					-- str width returned from truncate() may less than 2nd argument, need padding
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, { suffix, "MoreMsg" })
			return newVirtText
		end

		local ftMap = {
			vim = "indent",
			python = { "indent" },
			git = "",
		}

		return {
			fold_virt_text_handler = handler,
			close_fold_kinds = {},
			-- close_fold_kinds = { "imports", "comment" },
			provider_selector = function(bufnr, filetype, buftype)
				-- if you prefer treesitter provider rather than lsp,
				-- return ftMap[filetype] or {'treesitter', 'indent'}
				return ftMap[filetype]
				-- return { "treesitter", "indent" }

				-- refer to ./doc/example.lua for detail
			end,

			preview = {
				win_config = {
					border = { "", "─", "", "", "", "─", "", "" },
					winhighlight = "Normal:Normal",
					winblend = 0,
					maxheight = 20,
				},
				mappings = {
					scrollB = "<C-b>",
					scrollF = "<C-f>",
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					scrollE = "<C-E>",
					scrollY = "<C-Y>",
					jumpTop = "gg",
					jumpBot = "G",
					close = "q",
					switch = "<Tab>",
					trace = "<CR>",
				},
			},
		}
	end,
	config = function(_, opts)
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:,diff: ]]

		local ufo = require("ufo")
		ufo.setup(opts)

		local function peekOrHover()
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end

		vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open All Folds" })
		vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close All Folds" })
		vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, { desc = "Open Folds Except Kinds" })
		vim.keymap.set("n", "zm", ufo.closeFoldsWith, { desc = "Close Folds With" })
		vim.keymap.set("n", "K", peekOrHover, { desc = "Peek Or Hover" })
	end,
}

local M = {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"olimorris/persisted.nvim",
	},
}

M.opts = function()
	local banner = [[
      .          .
    ';;,.        ::'
  ,:::;,,        :ccc,
 ,::c::,,,,.     :cccc,
 ,cccc:;;;;;.    cllll,
 ,cccc;.;;;;;,   cllll;
 :cccc; .;;;;;;. coooo;
 ;llll;   ,:::::'loooo;
 ;llll:    ':::::loooo:
 :oooo:     .::::llodd:
 .;ooo:       ;cclooo:.
   .;oc        'coo;.
     .'         .,.
]]

	local header = {
		type = "text",
		val = vim.split(banner, "\n"),
		opts = {
			hl = "@alpha.header",
			position = "center",
		},
	}

	local function button(sc, txt, keybind)
		local opts = {
			position = "center",
			text = txt,
			shortcut = sc,
			cursor = 3,
			width = 50,
			align_shortcut = "right",
			hl_shortcut = "@alpha.shortcut",
			hl = "@alpha.text",
		}
		if keybind then
			opts.keymap = { "n", sc, keybind, { noremap = true, silent = true, nowait = true } }
		end
		return {
			type = "button",
			val = txt,
			on_press = function()
				local key = vim.api.nvim_replace_termcodes(sc, true, false, true)
				vim.api.nvim_feedkeys(key, "normal", false)
			end,
			opts = opts,
		}
	end

	local t = require "telescope"
	local tb = require "telescope.builtin"

	local buttons = {
		type = "group",
		val = {
			button("t", "  TODO", ":e ~/notes/TODO/index.md<CR>"),
			button("f", "󰈞  Find file", tb.find_files),
			button("e", "  New file", ":ene <BAR> startinsert<CR>"),
			button("p", "  Find project", t.extensions.projects.projects),
			button("s", "󱝩  Find Session", t.extensions.persisted.persisted),
			button("L", "  Load Session", ":SessionLoad<CR>"),
			button("z", "󰒲  Lazy", ":Lazy<CR>"),
			button("o", "󰄉  Recently used files", tb.oldfiles),
			button("l", "󰊄  Find text", tb.live_grep),
			button("c", "  Configuration", ":e $MYVIMRC<CR>"),
			button("u", "  Update", ":Lazy update<CR>"),
			button("h", "󰘥  Help", tb.help_tags),
			button("q", "  Quit", ":qa<CR>"),
		},
		opts = {
			position = "center",
			spacing = 1,
		},
	}

	local function get_nvim_version()
		local version = vim.version()
		local nvim_version_info = version.major .. "." .. version.minor .. "." .. version.patch
		return nvim_version_info
	end

	local version = {
		type = "text",
		val = " v" .. get_nvim_version(),
		opts = {
			hl = "@alpha.header",
			position = "center",
		},
	}

	local opts = {
		layout = {
			{ type = "padding", val = 1 },
			header,
			{ type = "padding", val = 1 },
			version,
			{ type = "padding", val = 2 },
			buttons,
			{ type = "padding", val = 2 },
		},
		opts = {
			margin = 44,
			noautocmd = true,
		},
	}

	return opts
end

M.config = function(_, opts)
	require("alpha").setup(opts)

	vim.api.nvim_create_autocmd("User", {
		pattern = "LazyVimStarted",
		callback = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			local footer = {
				type = "text",
				val = "󱐋 Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
				opts = {
					hl = "@alpha.footer",
					position = "center",
				},
			}
			opts.layout.footer = footer
			pcall(vim.cmd.AlphaRedraw)
		end,
	})
end

return M

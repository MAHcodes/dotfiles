local M = {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"olimorris/persisted.nvim",
	},
}

local select_banner = function()
	local banners = require "user.banners"
  local banner_width = 67 + 10

	return vim.o.columns >= banner_width and banners.full or banners.logo
end

M.opts = function()
	local header = {
		type = "text",
		val = vim.split(select_banner(), "\n"),
		opts = {
			hl = "AlphaHeader",
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
			hl_shortcut = "AlphaShortcut",
			hl = "AlphaButtons",
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
			button("t", "  TODO", ":e ~/notes/TODO.md<CR>"),
			button("J", "󱓧  Journal", function()
				local logseq = require "user.logseq"
				logseq.setup {
					graph_dir = "$HOME/notes",
				}
				logseq.open_journal()
			end),
			button("f", "󰈞  Find file", tb.find_files),
			button("e", "  New file", ":ene <BAR> startinsert<CR>"),
			button("p", "  Find project", t.extensions.projects.projects),
			button("s", "󱝩  Find Session", t.extensions.persisted.persisted),
			button("L", "  Load Session", ":SessionLoad<CR>"),
			button("z", "󰒲  Lazy", ":Lazy<CR>"),
			button("o", "󰄉  Recently used files", tb.oldfiles),
			button("l", "󰊄  Find text", tb.live_grep),
			button("c", "  Configuration", function()
				tb.find_files {
					search_dirs = { vim.fn.stdpath "config" },
				}
			end),
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
			hl = "AlphaHeader",
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
					hl = "AlphaFooter",
					position = "center",
				},
			}
			opts.layout.footer = footer
			pcall(vim.cmd.AlphaRedraw)
		end,
	})
end

return M

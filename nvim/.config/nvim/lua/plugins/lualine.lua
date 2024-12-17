local M = { "nvim-lualine/lualine.nvim" }

M.event = "VimEnter"

M.dependencies = {
	"nvim-tree/nvim-web-devicons",
	"folke/noice.nvim",
	"pnx/lualine-lsp-status",
}

M.opts = function()
	local utils = require "lualine.utils.utils"

	local diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		sections = { "error", "warn", "hint", "info" },
		symbols = { error = " ", warn = "  ", hint = "  ", info = "  " },
		colored = true,
		update_in_insert = false,
		always_visible = false,
	}

	local diff = {
		"diff",
		colored = true,
		symbols = { added = " ", modified = "󱗜 ", removed = " " },
	}

	local noice = require "noice"

	local command = {
		noice.api.status.command.get,
		cond = noice.api.status.command.has,
		icon = "󰘳",
	}

	local filetype = {
		"filetype",
		icons_enabled = true,
		colored = false,
		icon = nil,
	}

	local buftype = {
		function()
			return vim.opt.buftype._value
		end,
		icon = "",
	}

	local branch = {
		"branch",
		icons_enabled = true,
		icon = "",
	}

	local location = {
		"location",
		icon = "",
	}

	local progress = {
		"progress",
		fmt = function()
			return "%P/%L"
		end,
		icon = "󰛾",
	}

	local recording = {
		function()
			return vim.fn.reg_recording()
		end,
		icon = "󰑊",
	}

	local recorded = {
		function()
			return vim.fn.reg_recorded()
		end,
		icon = "󰐊",
	}

	local filename = {
		"filename",
		file_status = true,
		newfile_status = true,
		path = 0,
		shorting_target = 40,
		symbols = {
			modified = "[+]",
			readonly = "[-]",
			unnamed = "[No Name]",
			newfile = "[New]",
		},
	}

	local spaces = function()
		return "󰞘 " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. ""
	end

	local searchcount = {
		"searchcount",
		icon = "",
		fmt = function(s)
			return string.sub(s, 2, -2)
		end,
	}

	local datetime = {
		"datetime",
		style = "%=%H:%M",
		-- icon = "%=󱑁",
		color = "lualine_c_inactive",
	}

	local logo = {
		function()
			return ""
		end,
	}

	local lspstatus = {
		"lsp-status",
		show_count = true,
		colored = true,
		disabled_filetypes = {},
		colors = {
			active = {
				fg = utils.extract_color_from_hllist("fg", { "lualine_c_diff_added_normal" }, "#a6e3a1"),
			},
			inactive = {
				fg = utils.extract_color_from_hllist("fg", { "lualine_c_diff_removed_normal" }, "#f38ba8"),
			},
			count = {
				fg = utils.extract_color_from_hllist("fg", { "lualine_c_normal" }, "#cdd6f4"),
			},
		},
		icons = {
			active = "",
			inactive = " ",
		},
	}

	local harpoon = require "plugins.harpoon"

	return {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "│", right = "│" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				"NvimTree",
				"DressingInput",
				"Outline",
				"alpha",
				"oil",
			},
			always_divide_middle = false,
			globalstatus = true,
		},
		sections = {
			lualine_a = {
				logo,
				"mode",
				recording,
				recorded,
				filename,
				"filesize",
			},
			lualine_b = {
				branch,
			},
			lualine_c = {
				diff,
				datetime,
			},
			lualine_x = {
				diagnostics,
				lspstatus,
			},
			lualine_y = {
				harpoon.lualine,
				command,
				searchcount,
				"fileformat",
				buftype,
				filetype,
				spaces,
				"encoding",
			},
			lualine_z = {
				location,
				progress,
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = {
			"man",
			"mason",
			"nvim-dap-ui",
			"quickfix",
			"symbols-outline",
			"trouble",
		},
	}
end

return M

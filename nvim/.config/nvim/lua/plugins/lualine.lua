return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"folke/noice.nvim",
	},
	opts = function()
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
					{
						function()
							return ""
						end,
					},
					"mode",
					recording,
					recorded,
					filename,
					"filesize",
				},
				lualine_b = { branch },
				lualine_c = { diff, datetime },
				lualine_x = { diagnostics },
				lualine_y = { command, searchcount, "fileformat", buftype, filetype, spaces, "encoding" },
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
			extensions = { "man", "mason", "nvim-dap-ui", "quickfix", "symbols-outline", "trouble" },
		}
	end,
}

local status_ok, color_picker = pcall(require, "color-picker")
if not status_ok then
	return
end

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<A-c>", "<cmd>PickColor<cr>", opts)
vim.keymap.set("i", "<A-c>", "<cmd>PickColorInsert<cr>", opts)

color_picker.setup({ -- for changing icons & mappings
	["icons"] = { "ﱢ", "" },
	["border"] = "rounded", -- none | single | double | rounded | solid | shadow
	["keymap"] = { -- mapping example:
		["U"] = "<Plug>ColorPickerSlider5Decrease",
		["O"] = "<Plug>ColorPickerSlider5Increase",
	},
})

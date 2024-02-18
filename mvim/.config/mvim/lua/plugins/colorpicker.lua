return {
	"ziontee113/color-picker.nvim",
  lazy = true,
  keys = {
    { "<A-c>", "<cmd>PickColor<cr>", mode = "n", desc = "Pick Color" },
    { "<A-c>", "<cmd>PickColorInsert<cr>", mode = "i", desc = "Pick Color" },
  },
	opts = {
		["icons"] = { "ﱢ", "" },
		["border"] = "rounded",
		["keymap"] = {
			["U"] = "<Plug>ColorPickerSlider5Decrease",
			["O"] = "<Plug>ColorPickerSlider5Increase",
		},
	},
}

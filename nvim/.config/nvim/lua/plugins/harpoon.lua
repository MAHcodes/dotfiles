local M = { "ThePrimeagen/harpoon" }

M.branch = "harpoon2"

M.dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"letieu/harpoon-lualine",
}

-- basic telescope configuration
local toggle_telescope = function()
	local harpoon = require "harpoon"
	local conf = require("telescope.config").values
	local file_paths = {}

	for _, item in ipairs(harpoon:list().items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table {
				results = file_paths,
			},
			previewer = conf.file_previewer {},
			sorter = conf.generic_sorter {},
		})
		:find()
end

local add = function()
	require("harpoon"):list():add()
end

local prev = function()
	require("harpoon"):list():prev()
end

local next = function()
	require("harpoon"):list():next()
end

local select = function(n)
	return function()
		require("harpoon"):list():select(n)
	end
end

local toggle_ui = function()
	local harpoon = require "harpoon"
	harpoon.ui:toggle_quick_menu(harpoon:list(), M.opts)
end

M.keys = {
	{ "<leader>ht", toggle_telescope, desc = "Telescope Toggle" },
	{ "<leader>ha", add, desc = "Add File" },
	{ "<leader>hu", toggle_ui, desc = "Toggle UI" },
	{ "<leader>hp", prev, desc = "Prev" },
	{ "<leader>hn", next, desc = "Next" },
	{ "<leader>h1", select(1), desc = "Select 1" },
	{ "<leader>h2", select(2), desc = "Select 2" },
	{ "<leader>h3", select(3), desc = "Select 3" },
	{ "<leader>h4", select(4), desc = "Select 4" },
	{ "<leader>h5", select(5), desc = "Select 5" },
}

M.opts = {
	border = "rounded",
	width = 30,
}

M.config = function()
	local harpoon = require "harpoon"
	harpoon:setup()
end

local icons = require "user.icons"

M.whichkey = { "<leader>h", group = "Harpoon", icon = icons.misc.ArrowProjectile }

M.lualine = {
	"harpoon2",
	icon = icons.misc.ArrowProjectile,
	indicators = { "1", "2", "3", "4", "5" },
	active_indicators = { "[1]", "[2]", "[3]", "[4]", "[5]" },
	_separator = " ",
	no_harpoon = "",
	color_active = nil,
}

return M

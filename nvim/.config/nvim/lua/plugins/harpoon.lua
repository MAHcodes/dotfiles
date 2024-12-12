return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		{
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	keys = {
		{ "<leader>ht", "<cmd>HarpoonTelescope<CR>", desc = "Telescope Toggle" },
		{ "<leader>ha", "<cmd>HarpoonAdd<CR>", desc = "Add File" },
		{ "<leader>hu", "<cmd>HarpoonToggleUI<CR>", desc = "Toggle UI" },
		{ "<leader>hp", "<cmd>HarpoonPrev<CR>", desc = "Prev" },
		{ "<leader>hn", "<cmd>HarpoonNext<CR>", desc = "Next" },
		{ "<leader>h1", "<cmd>HarpoonSelect 1<CR>", desc = "Select 1" },
		{ "<leader>h2", "<cmd>HarpoonSelect 2<CR>", desc = "Select 2" },
		{ "<leader>h3", "<cmd>HarpoonSelect 3<CR>", desc = "Select 3" },
		{ "<leader>h4", "<cmd>HarpoonSelect 4<CR>", desc = "Select 4" },
		{ "<leader>h5", "<cmd>HarpoonSelect 5<CR>", desc = "Select 5" },
	},
	opts = {
		border = "rounded",
		width = 30,
	},
	config = function(_, opts)
		local harpoon = require "harpoon"

		harpoon:setup()

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
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

		vim.api.nvim_create_user_command("HarpoonTelescope", function()
			toggle_telescope(harpoon:list())
		end, {})

		vim.api.nvim_create_user_command("HarpoonAdd", function()
			harpoon:list():add()
		end, {})

		vim.api.nvim_create_user_command("HarpoonToggleUI", function()
			harpoon.ui:toggle_quick_menu(harpoon:list(), opts)
		end, {})

		vim.api.nvim_create_user_command("HarpoonSelect", function(cmd_opts)
			harpoon:list():select(tonumber(cmd_opts.args))
		end, { nargs = 1 })

		vim.api.nvim_create_user_command("HarpoonPrev", function()
			harpoon:list():prev()
		end, {})

		vim.api.nvim_create_user_command("HarpoonNext", function()
			harpoon:list():next()
		end, {})
	end,
}

local M = {
	"mfussenegger/nvim-dap",
}

M.dependencies = {
	{
		"nvim-neotest/nvim-nio",
    lazy = true,
	},
	{
		"rcarriga/nvim-dap-ui",
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle {}
				end,
				desc = "Dap: UI",
			},
			{
				"<leader>de",
				function()
					require("dapui").eval()
				end,
				desc = "Dap: Eval",
				mode = { "n", "v" },
			},
		},
		opts = {},
		config = function(_, opts)
			local dap = require "dap"
			local dapui = require "dapui"
			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open {}
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close {}
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close {}
			end
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
    lazy = true,
		opts = {},
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		cmd = { "DapInstall", "DapUninstall" },
		opts = {
			automatic_installation = true,
			handlers = {},
			ensure_installed = {},
		},
	},
}

M.keys = {
	{
		"<leader>dB",
		function()
			require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
		end,
		desc = "Dap: Breakpoint Condition",
	},
	{
		"<leader>db",
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "Dap: Toggle Breakpoint",
	},
	{
		"<leader>dc",
		function()
			require("dap").continue()
		end,
		desc = "Dap: Continue",
	},
	{
		"<leader>da",
		function()
			require("dap").continue()
		end,
		desc = "Dap: Run with Args",
	},
	{
		"<leader>dC",
		function()
			require("dap").run_to_cursor()
		end,
		desc = "Dap: Run to Cursor",
	},
	{
		"<leader>dg",
		function()
			require("dap").goto_()
		end,
		desc = "Dap: Go to line (no execute)",
	},
	{
		"<leader>di",
		function()
			require("dap").step_into()
		end,
		desc = "Dap: Step Into",
	},
	{
		"<leader>dj",
		function()
			require("dap").down()
		end,
		desc = "Dap: Down",
	},
	{
		"<leader>dk",
		function()
			require("dap").up()
		end,
		desc = "Dap: Up",
	},
	{
		"<leader>dl",
		function()
			require("dap").run_last()
		end,
		desc = "Dap: Run Last",
	},
	{
		"<leader>do",
		function()
			require("dap").step_out()
		end,
		desc = "Dap: Step Out",
	},
	{
		"<leader>dO",
		function()
			require("dap").step_over()
		end,
		desc = "Dap: Step Over",
	},
	{
		"<leader>dp",
		function()
			require("dap").pause()
		end,
		desc = "Dap: Pause",
	},
	{
		"<leader>dr",
		function()
			require("dap").repl.toggle()
		end,
		desc = "Dap: Toggle REPL",
	},
	{
		"<leader>ds",
		function()
			require("dap").session()
		end,
		desc = "Dap: Session",
	},
	{
		"<leader>dt",
		function()
			require("dap").terminate()
		end,
		desc = "Dap: Terminate",
	},
	{
		"<leader>dw",
		function()
			require("dap.ui.widgets").hover()
		end,
		desc = "Dap: Widgets",
	},
}

M.config = function()
	vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

	local icons = {
		Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
		Breakpoint = " ",
		BreakpointCondition = " ",
		BreakpointRejected = { " ", "DiagnosticError" },
		LogPoint = ".>",
	}

	for name, sign in pairs(icons) do
		sign = type(sign) == "table" and sign or { sign }
		vim.fn.sign_define(
			"Dap" .. name,
			{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
		)
	end
end

M.whichkey = { "<leader>d", group = "Dap" }

return M

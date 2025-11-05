return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = function()
		-- Open dap-ui on dap events
		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>u", function()
			require("dapui").toggle()
		end, { desc = "Toggle dap-ui window" })
		keymap.set("n", "<leader>ue", function()
			require("dapui").eval()
		end, { desc = "Toggle dap-ui window" })
	end,
}

return {
	"ThePrimeagen/harpoon",
	config = function()
		local keymap = vim.keymap

		keymap.set("n", "<leader>h", function()
			require("harpoon.ui").toggle_quick_menu()
		end, { desc = "Toggle harpoon window" })
		keymap.set("n", "<leader>a", function()
			require("harpoon.mark").add_file()
		end, { desc = "Mark file for harpoon nav" })
	end,
}

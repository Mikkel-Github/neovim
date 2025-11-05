return {
	"stevearc/aerial.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local keymap = vim.keymap
		require("aerial").setup({
			-- optionally use on_attach to set keymaps when aerial has attached to a buffer
			on_attach = function(bufnr)
				-- Jump forwards/backwards with '{' and '}'
				keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
		})

		keymap.set("n", "<leader>A", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial window" })
	end,
}

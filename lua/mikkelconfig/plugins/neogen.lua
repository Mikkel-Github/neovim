return {
	"danymat/neogen",
	config = true,
	-- Uncomment next line if you want to follow only stable versions
	version = "*",

	config = function()
		require("neogen").setup({
			-- snippet_engine = "luasnip",
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>nf", function()
			require("neogen").generate()
		end, { desc = "Generate annotations for current function" })
		keymap.set("n", "<leader>nc", function()
			require("neogen").generate({ type = "class" })
		end, { desc = "Generate annotations for current class" })
		keymap.set("n", "<leader>nt", function()
			require("neogen").generate({ type = "type" })
		end, { desc = "Generate annotations for current type" })
		keymap.set("n", "<leader>nF", function()
			require("neogen").generate({ type = "file" })
		end, { desc = "Generate annotations for current file" })

		keymap.set("i", "<C-l>", function()
			require("neogen").jump_next()
		end, { desc = "Go to next annotation", noremap = true })
		keymap.set("i", "<C-h>", function()
			require("neogen").jump_prev()
		end, { desc = "Go to previous annotation", noremap = true })
	end,
}

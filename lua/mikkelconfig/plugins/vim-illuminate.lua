return {
	"RRethy/vim-illuminate",
	config = function()
		local illuminate = require("illuminate")

		illuminate.configure({
			-- min_count_to_highlight: minimum number of matches required to perform highlighting
			min_count_to_highlight = 2,
		})
	end,
}

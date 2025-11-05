vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- increment/decrement numbers
vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- dismiss notification
vim.keymap.set("n", "<Esc>", function()
	require("notify").dismiss()
end, { desc = "dismiss notify popup and clear hlsearch" })

local function toggle_half_size()
	local winwidth = vim.fn.winwidth(0)
	local winheight = vim.fn.winheight(0)
	local screenwidth = vim.o.columns
	local screenheight = vim.o.lines - vim.o.cmdheight -- Exclude command line height

	-- Get the current window's position
	local cur_win = vim.api.nvim_get_current_win()
	local cur_pos = vim.api.nvim_win_get_position(cur_win)
	local cur_width = vim.api.nvim_win_get_width(cur_win)
	local cur_height = vim.api.nvim_win_get_height(cur_win)

	-- Get the window's neighbor positions to detect the split orientation
	local neighbor_win = nil
	local is_vertical_split = false
	local is_horizontal_split = false

	-- Iterate over all windows and detect the orientation
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if win ~= cur_win then
			local adj_pos = vim.api.nvim_win_get_position(win)
			local adj_width = vim.api.nvim_win_get_width(win)
			local adj_height = vim.api.nvim_win_get_height(win)

			-- Check if adjacent window is split vertically (same height, adjacent width)
			if cur_pos[1] == adj_pos[1] and cur_height == adj_height then
				neighbor_win = win
				is_vertical_split = true
				break
			end

			-- Check if adjacent window is split horizontally (same width, adjacent height)
			if cur_pos[2] == adj_pos[2] and cur_width == adj_width then
				neighbor_win = win
				is_horizontal_split = true
				break
			end
		end
	end

	-- Now that we know if it's a vertical or horizontal split, toggle accordingly
	if is_vertical_split then
		-- Handle vertical split: toggle to half-width
		if winwidth == math.floor(screenwidth / 2) then
			vim.cmd("vertical resize |") -- Maximize width
		else
			vim.cmd("vertical resize " .. math.floor(screenwidth / 2)) -- Half-width
		end
	elseif is_horizontal_split then
		-- Handle horizontal split: toggle to half-height
		if winheight == math.floor(screenheight / 2) then
			vim.cmd("resize |") -- Maximize height
		else
			vim.cmd("resize " .. math.floor(screenheight / 2)) -- Half-height
		end
	end
end

vim.keymap.set("n", "<leader>sw", toggle_half_size, { desc = "Toggle between half-size and maximized" })

local swap_state = nil
local function swap_panes()
	local current_win = vim.api.nvim_get_current_win()

	if not swap_state then
		-- First selection
		swap_state = current_win
		print("Window selected! Move to another window and press the keybind again to swap.")
	else
		-- Second selection (swap windows)
		if swap_state ~= current_win then
			-- Get window positions
			local first_buf = vim.api.nvim_win_get_buf(swap_state)
			local second_buf = vim.api.nvim_win_get_buf(current_win)

			-- Swap buffers
			vim.api.nvim_win_set_buf(swap_state, second_buf)
			vim.api.nvim_win_set_buf(current_win, first_buf)

			print("Windows swapped!")
		else
			print("Cannot swap a window with itself!")
		end
		swap_state = nil -- Reset selection
	end
end
vim.keymap.set("n", "<leader>sp", swap_panes, { desc = "Select or swap two windows" })

-- tab management
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to new tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Opean current buffer in new tab" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>")
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

vim.keymap.set("n", "-", "<cmd>foldclose<CR>", { desc = "Close code fold" })
vim.keymap.set("n", "+", "<cmd>foldopen<CR>", { desc = "Open code fold" })

vim.keymap.set("n", "<leader>cf", "<cmd>set wrap!<CR>", { desc = "Toggles code wrapping" })

local function substitute_popup()
	local mode = vim.fn.mode()
	local visual_start, visual_end = nil, nil

	-- Capture visual selection BEFORE leaving visual mode
	if mode == "v" or mode == "V" or mode == "" then
		visual_start = vim.fn.line("'<")
		visual_end = vim.fn.line("'>")
	end

	vim.ui.input({ prompt = "Find: " }, function(find_text)
		if not find_text or find_text == "" then
			return
		end

		vim.ui.input({ prompt = "Replace with: " }, function(replace_text)
			if not replace_text or replace_text == "" then
				return
			end

			local scopes = {
				["1"] = "Current line",
				["2"] = "Current selection",
				["3"] = "Current function",
				["4"] = "Current class",
				["5"] = "Entire file",
			}

			local scope_keys = { "1. Line", "2. Selection", "3. Function", "4. Class", "5. File" }
			vim.ui.select(scope_keys, { prompt = "Scope:" }, function(choice)
				if not choice then
					return
				end

				local scope = scopes[choice:sub(1, 1)]
				local cmd = ""

				if scope == "Current line" then
					cmd = string.format(":%d s/%s/%s/g", vim.fn.line("."), find_text, replace_text)
				elseif scope == "Current selection" then
					-- Reapply selection before running the command
					if visual_start and visual_end then
						vim.cmd("normal! gv") -- Restore selection
						cmd = string.format(":'<,'>s/%s/%s/g", find_text, replace_text)
					else
						vim.notify("No selection found!", vim.log.levels.WARN)
						return
					end
				elseif scope == "Current function" then
					local start_row, end_row = get_treesitter_scope("function")
					if start_row and end_row then
						cmd = string.format(":%d,%d s/%s/%s/g", start_row, end_row, find_text, replace_text)
					else
						vim.notify("No function found", vim.log.levels.WARN)
						return
					end
				elseif scope == "Current class" then
					local start_row, end_row = get_treesitter_scope("class")
					if start_row and end_row then
						cmd = string.format(":%d,%d s/%s/%s/g", start_row, end_row, find_text, replace_text)
					else
						vim.notify("No class found", vim.log.levels.WARN)
						return
					end
				elseif scope == "Entire file" then
					cmd = string.format(":%s s/%s/%s/g", "%", find_text, replace_text)
				end

				if cmd ~= "" then
					-- Execute safely and catch errors
					local success, err = pcall(vim.cmd, cmd)
					if not success and string.match(err, "E486: Pattern not found") then
						vim.notify("Pattern not found: " .. find_text, vim.log.levels.WARN)
					elseif not success then
						vim.notify("Error: " .. err, vim.log.levels.ERROR)
					end
				end
			end)
		end)
	end)
end

-- Key mappings
vim.keymap.set("n", "<leader>sr", substitute_popup, { desc = "Substitute with pop-up UI" })
vim.keymap.set("v", "<leader>sr", substitute_popup, { desc = "Substitute with pop-up UI" })

-- CamelCaseMotion
vim.keymap.set({ "n", "o", "x" }, "w", "<Plug>CamelCaseMotion_w", { silent = true })
vim.keymap.set({ "n", "o", "x" }, "b", "<Plug>CamelCaseMotion_b", { silent = true })
vim.keymap.set({ "n", "o", "x" }, "e", "<Plug>CamelCaseMotion_e", { silent = true })

-- For text objects (this is what you want):
vim.keymap.set({ "o", "x" }, "iW", "<Plug>CamelCaseMotion_ie", { silent = true }) -- inner subword
vim.keymap.set({ "o", "x" }, "aW", "<Plug>CamelCaseMotion_ae", { silent = true }) -- a subword

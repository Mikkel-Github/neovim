return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Capture shell command output
		local function capture(cmd)
			local f = assert(io.popen(cmd, "r"))
			local s = assert(f:read("*a"))
			f:close()
			return s:gsub("\r", "") -- Remove unwanted carriage returns
		end

		-- Get current date and time (excluding day name)
		local function get_date()
			return os.date(" %d-%m-%Y   %H:%M:%S")
		end

		-- Generate large ASCII art for the day header
		local function get_ascii_day()
			local day = os.date("%A"):upper()
			if vim.fn.executable("figlet") == 1 then
				return vim.split(capture("figlet -f 3-d -w 100 " .. day), "\n") -- Bigger font
			elseif vim.fn.executable("toilet") == 1 then
				return vim.split(capture("toilet -f bigmono12 " .. day), "\n")
			else
				return { " " .. day .. " " } -- Fallback text
			end
		end

		-- Get Git information (branch + latest commit)
		local function get_git_info()
			if vim.fn.isdirectory(".git") == 1 then
				local branch = capture("git branch --show-current"):gsub("\n", "")
				local last_commit = capture("git log -1 --pretty=format:'%s (%cr)'")
				if branch ~= "" then
					-- return " " .. branch .. " - Last commit: " .. last_commit
					return " " .. branch
				end
			end
			return ""
		end

		-- Scan files for TODOs and BUGs
		local function count_todos_bugs()
			-- Run ripgrep and handle errors
			local function safe_rg(pattern)
				local result = capture("rg -t lua -t js -t ts -t py -i '" .. pattern .. "' | wc -l 2>/dev/null") or ""
				return tonumber(result:match("%d+")) or 0 -- Ensure we get a valid number
			end

			local todos = safe_rg("TODO:")
			local warns = safe_rg("WARN:")
			local bugs = safe_rg("BUG:")
			local fixme = safe_rg("FIXME:")

			return string.format(" : %d  |   : %d  |  !: %d  |   : %d", todos, warns, fixme, bugs)
		end

		function centerText(text, width)
			local totalPadding = width - #text
			local leftPadding = math.floor(totalPadding / 2)
			local rightPadding = totalPadding - leftPadding
			return string.rep(" ", leftPadding) .. text .. string.rep(" ", rightPadding)
		end

		-- Set Dashboard Header (ASCII Day Name + Date)
		-- dashboard.section.header.val = vim.tbl_extend("force", get_ascii_day(), { "", get_date() })
		dashboard.section.header.val = get_ascii_day()

		-- Set Footer (Git Info, TODOs/BUGs, Random Quote)
		dashboard.section.footer.val = {
			centerText(get_date(), 80),
			centerText(get_git_info(), 80),
			centerText(count_todos_bugs(), 80),
		}

		-- Dashboard Menu
		dashboard.section.buttons.val = {
			dashboard.button("s", " Open last session", "<cmd>SessionRestore<CR>"),
			dashboard.button("h", " Recently opened files", ":Telescope oldfiles<CR>"),
			dashboard.button("f", " Find file", ":Telescope find_files<CR>"),
			dashboard.button("e", " New file", ":enew<CR>"),
			dashboard.button("b", " Jump to bookmarks", ":Telescope marks<CR>"),
			dashboard.button("t", " Show TODOs", ":TodoLocList keywords=TODO,FIXME<CR>"),
			dashboard.button("x", " Show BUGs", ":TodoLocList keywords=BUG,ERROR<CR>"),
			dashboard.button("w", " Show WARNINGS", ":TodoLocList keywords=WARNING,WARN,PERF<CR>"),
			dashboard.button("f", "! Show FIXMEs", ":TodoLocList keywords=FIXME<CR>"),
			dashboard.button("p", " Update plugins", ":Lazy sync<CR>"),
			dashboard.button("q", " Exit", ":qa<CR>"),
		}

		alpha.setup(dashboard.config)

		-- Redraw Dashboard when opening
		vim.api.nvim_create_autocmd("User", {
			pattern = "AlphaReady",
			callback = function()
				-- dashboard.section.header.val = vim.tbl_extend("force", get_ascii_day(), { "", get_date() })
				dashboard.section.header.val = get_ascii_day()
				dashboard.section.footer.val = {
					centerText(get_date(), 40),
					centerText(get_git_info(), 40),
					centerText(count_todos_bugs(), 40),
				}
				alpha.redraw()
			end,
			once = false,
		})
	end,
}

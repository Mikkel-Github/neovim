--[[ return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	config = function()
		vim.cmd("colorscheme kanagawa")
	end,
} ]]

--[[ return {
	"patstockwell/vim-monokai-tasty",
	priority = 1000,
	config = function()
		vim.cmd("colorscheme vim-monokai-tasty")
	end,
} ]]

--[[ return {
	"eldritch-theme/eldritch.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
} ]]

--[[ return {
	"tomasr/molokai",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd("colorscheme molokai")
	end,
} ]]

--[[ return {
	"slugbyte/lackluster.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local lackluster = require("lackluster")

		-- Setup with custom colors
		lackluster.setup({
			tweak_color = {
				-- you can set a value to a custom hexcode like' #aaaa77' (hashtag required)
				-- or if the value is 'default' or nil it will use lackluster's default color
				lack = "default",
				-- lack = "default",
				luster = "default",
				orange = "default",
				yellow = "default",
				green = "default",
				blue = "default",
				red = "default",
				-- WARN: Watchout! messing with grays is probs a bad idea, its very easy to shoot yourself in the foot!
				-- black = "default",
				-- gray1 = "default",
				-- gray2 = "default",
				-- gray3 = "default",
				-- gray4 = "default",
				-- gray5 = "default",
				-- gray6 = "default",
				-- gray7 = "default",
				-- gray8 = "default",
				-- gray9 = "default",
			},
			tweak_highlight = {
				["@comment"] = {
					overwrite = false, -- overwrite falsey will extend/update lackluster's defaults (nil also does this)
					bold = false,
					italic = true,
					-- see `:help nvim_set_hl` for all possible keys
				},
				["@type"] = {
					overwrite = false, -- overwrite falsey will extend/update lackluster's defaults (nil also does this)
					bold = false,
					italic = false,
					-- see `:help nvim_set_hl` for all possible keys
				},
				["@lsp.typemod.function.readonly"] = {
					bold = true,
				},
				["@lsp.typemod.function.local"] = {
					overwrite = false, -- overwrite falsey will extend/update lackluster's defaults (nil also does this)
					bold = true,
					italic = false,
					-- see `:help nvim_set_hl` for all possible keys
				},
				["@function.builtin"] = {
					overwrite = false, -- overwrite falsey will extend/update lackluster's defaults (nil also does this)
					bold = true,
					italic = false,
					-- see `:help nvim_set_hl` for all possible keys
				},
				["@string.escape"] = {
					overwrite = false, -- overwrite falsey will extend/update lackluster's defaults (nil also does this)
					bold = true,
					italic = false,
					-- see `:help nvim_set_hl` for all possible keys
				},
				["@operator"] = {
					overwrite = false, -- overwrite falsey will extend/update lackluster's defaults (nil also does this)
					bold = true,
					italic = false,
					-- see `:help nvim_set_hl` for all possible keys
				},
				["@keyword.return"] = {
					overwrite = false, -- overwrite falsey will extend/update lackluster's defaults (nil also does this)
					bold = true,
					italic = false,
					-- see `:help nvim_set_hl` for all possible keys
				},
				["@variable"] = { fg = "#ffffff", bold = false },
				["@variable.builtin"] = { fg = "#ffffff" },
				["@variable.member"] = { fg = "#ffffff", bold = false }, -- Covers LSP-based variable highlights
				["@lsp.typemod.enumMember"] = { fg = "#db7f39" },
				["@function.method.call"] = { fg = "#db7f39" },
				["@lsp.type.property"] = { fg = "#db7f39" },
				["@lsp.typemod.variable.defaultLibrary.typescript"] = { fg = "#7788AA", bold = true }, -- Covers additional default libraries
				["@punctuation.delimiter"] = { fg = "#ffffff" },
				["@constructor"] = { fg = "#7788AA", bold = false },
				-- ["@property"] = { fg = "#db7f39", bold = false },
				["@tag.builtin"] = { fg = "#ff1466", bold = false },
				["@tag"] = { fg = "#ff1466", bold = false },
				["@number"] = { fg = "#ffffff" },
				["@number.function_argument"] = { fg = "#00ff00" },
				["NvimTreeFolderIcon"] = { fg = "#ff1466" },
			},

			-- You can overwrite the following syntax colors by setting them to one of...
			--   1) a hexcode like "#a1b2c3" for a custom color.
			--   2) "default" or nil will just use whatever lackluster's default is.
			tweak_syntax = {
				-- string = "default",
				string = "#44b851", -- custom hexcode
				-- string = color.green, -- lackluster color
				string_escape = "#db7f39",
				comment = "default",
				builtin = "default", -- builtin modules and functions
				type = "#7788AA",
				keyword = "#ff1466",
				operator = "#ff1466",
				lsp_typemod_parameter_declaration_typescript = "#00ff00",
				keyword_return = "#ff1466",
				keyword_exception = "#ff1466",
			},
			-- You can overwrite the following background colors by setting them to one of...
			--   1) a hexcode like "#a1b2c3" for a custom color
			--   2) "none" for transparency
			--   3) "default" or nil will just use whatever lackluster's default is.
			tweak_background = {
				normal = "default", -- main background
				-- normal = 'none',    -- transparent
				-- normal = '#a1b2c3',    -- hexcode
				-- normal = color.green,    -- lackluster color
				telescope = "default", -- telescope
				menu = "default", -- nvim_cmp, wildmenu ... (bad idea to transparent)
				popup = "default", -- lazy, mason, whichkey ... (bad idea to transparent)
			},
			disable_plugin = {
				bufferline = true,
				cmp = false,
				dashboard = false,
				flash = false,
				git_gutter = false,
				git_signs = false,
				headline = false,
				indentmini = false,
				lazy = false,
				lightbulb = false,
				lsp_config = false,
				mason = false,
				mini_diff = false,
				navic = false,
				noice = false,
				notify = false,
				oil = false,
				rainbow_delimiter = false, -- if you want color-rainbows you should disable this
				scollbar = false,
				telescope = false,
				todo_comments = false,
				tree = false,
				trouble = false,
				which_key = true,
				yanky = false,
			},
		})

		-- Set colorscheme AFTER calling setup
		vim.cmd.colorscheme("lackluster")
	end,
} ]]
--[[ return {
    "jesseleite/nvim-noirbuddy",
    dependencies = {
        { "tjdevries/colorbuddy.nvim" },
    },
    lazy = false,
    priority = 1000,
    opts = {
    },
    init = function()
        vim.cmd("colorscheme noirbuddy")
    end,
} ]]

return {
	"jesseleite/nvim-noirbuddy",
	dependencies = { "tjdevries/colorbuddy.nvim" },
	lazy = false,
	priority = 1000,
	config = function()
		-- Set up noirbuddy
		require("noirbuddy").setup({
			colors = {
				primary = "#00ff00",
				secondary = "#ff1466",
				-- background = "#18181A",

				diagnostic_error = "#ff0000",
				diagnostic_warning = "#2A2A2A",
				diagnostic_info = "#2A2A2A",
				diagnostic_hint = "#444444",

				diff_add = "#00ff00",
				diff_change = "#db7f39",
				diff_delete = "#ff1466",
			},
			styles = {
				italic = true,
				bold = false,
				underline = false,
				undercurl = false,
			},
		})

		-- Ensure colorbuddy is loaded and setup before using Group.new
		local colorbuddy = require("colorbuddy")
		local Color = colorbuddy.Color
		local colors = colorbuddy.colors
		local Group = colorbuddy.Group
		local styles = colorbuddy.styles

		Color.new("black", "#000000")
		Color.new("orange", "#ebbd34")
		Color.new("blue", "#34e2eb")
		Color.new("purple", "#eb34ba")
		Color.new("cyan", "#34eb9f")

		-- Change the color of constants
		Group.new("TelescopeBorder", colors.secondary) -- This will set the color of constants to your `primary` color (#00ff00)
		Group.new("CursorLineNr", colors.secondary) -- This will set the color of constants to your `primary` color (#00ff00)
		Group.new("@function", colors.white, colors.background, styles.bold)

		Group.new("nvimtreefoldericon", colors.secondary)
		Group.new("WhichKey", colors.primary)
		Group.new("WhichKeyGroup", colors.secondary)

		Group.new("BufferLineBufferSelected", colors.secondary)
		Group.new("BufferLineHintSelected", colors.secondary)
		Group.new("IblScope", colors.secondary)

		Group.new("TodoBgTODO", colors.black, colors.primary, styles.bold)
		Group.new("TodoFgTODO", colors.primary)
		Group.new("TodoBgWARN", colors.black, colors.orange, styles.bold)
		Group.new("TodoFgWARN", colors.orange)
		Group.new("TodoBgNOTE", colors.black, colors.blue, styles.bold)
		Group.new("TodoFgNOTE", colors.blue)
		Group.new("TodoBgTEST", colors.black, colors.purple, styles.bold)
		Group.new("TodoFgTEST", colors.purple)
		Group.new("TodoBgHACK", colors.black, colors.cyan, styles.bold)
		Group.new("TodoFgHACK", colors.cyan)
		Group.new("Visual", colors.black, colors.secondary)

		Group.new("AerialLine", colors.secondary)
		Group.new("AerialLineNC", colors.secondary)
	end,
}
--[[ return {
	"olivercederborg/poimandres.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("poimandres").setup({
			-- leave this setup function empty for default config
			-- or refer to the configuration section
			-- for configuration options
			bold_vert_split = false,
		})
	end,

	-- optionally set the colorscheme within lazy config
	init = function()
		vim.cmd("colorscheme poimandres")
	end,
} ]]

--[[ return {
	"n1ghtmare/noirblaze-vim",
	lazy = false,
	priority = 1000,
	init = function()
		vim.cmd("colorscheme noirblaze")
		-- vim.cmd.colorscheme("lackluster-hack") -- my favorite
		-- vim.cmd.colorscheme("lackluster-mint")
	end,
} ]]

--[[ return {
	"aliqyan-21/darkvoid.nvim",
	lazy = false,
	priority = 1000,
} ]]

--[[ return {
	"jesseleite/nvim-noirbuddy",
	dependencies = {
		{ "tjdevries/colorbuddy.nvim" },
	},
	lazy = false,
	priority = 1000,
	opts = {
		preset = "minimal",
		colors = {
			-- primary = "#6EE2FF",
			-- secondary = "#267FB5",

			diagnostic_error = "#EC0034",
			diagnostic_warning = "#ff7700",
			diagnostic_info = "#d5d5d5",
			diagnostic_hint = "#f5f5f5",
			diff_add = "#f5f5f5",
			diff_change = "#737373",
			diff_delete = "#EC0034",
		},
		-- All of your `setup(opts)` will go here
	},
} ]]

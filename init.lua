require("mikkelconfig.core")
require("mikkelconfig.lazy")

vim.notify = require("notify")

-- import lspconfig
local lspconfig = require("lspconfig")

-- Setup rust-analyzer
lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			cargo = {
				loadOutDirsFromCheck = true,
			},
			procMacro = {
				enable = true,
			},
			rustfmt = {
				enable = true,
			},
			diagnostics = {
				enable = true,
				disabled = {}, -- Optionally disable specific lints
			},
		},
	},
})

vim.filetype.add({
	extension = {
		vs = "glsl",
		fs = "glsl",
		vert = "glsl",
		frag = "glsl",
		geom = "glsl",
		glsl = "glsl",
	},
})

vim.api.nvim_create_user_command("RunClippy", function()
	vim.cmd("!cargo clippy")
end, {})

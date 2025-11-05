return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				-- "rust_analyzer",
				"prismals",
				-- "eslint",
				-- "volar",
				"ts_ls",
				-- "vtsls",
				"vue_ls",
				-- "vue-language-server",
				-- "tsserver",
				"cssls",
				"clangd",
				"cmake",
				"dockerls",
				"docker_compose_language_service",
				"html",
				"jsonls",
				"glsl_analyzer",
				"jdtls",
				"intelephense",
				"basedpyright",
				"tailwindcss",
				"lemminx",
				"lua_ls",
			},
			automatic_installation = true,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint",
				-- "eslint_d",
				"stylelint",
				"prettierd",
				"cpplint",
				"clang-format",
			},
		})
	end,
}

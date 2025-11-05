return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local configs = require("lspconfig.configs")
		local util = require("lspconfig.util")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		-- If this build of nvim-lspconfig doesn't have vue_ls yet, register it.
		if not configs.vue_ls then
			configs.vue_ls = {
				default_config = {
					cmd = { "vue-language-server", "--stdio" },
					filetypes = { "vue" },
					root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
					init_options = {
						-- vue_ls v3 expects a TS LSP (vtsls/ts_ls/typescript-tools) running alongside.
						-- You can optionally point to a TS SDK if you want to force a specific TS version:
						-- typescript = { tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib" },
						typescript = {},
					},
					settings = {},
				},
			}
		end

		-- Keymaps on attach
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
			end,
		})

		-- Capabilities for completion
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Diagnostic signs
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		--------------------------------------------------------------------------
		-- Explicit server setups (no mason_lspconfig.setup_handlers anywhere)
		--------------------------------------------------------------------------

		-- Vue (vue-language-server)
		lspconfig.vue_ls.setup({
			capabilities = capabilities,
			filetypes = { "vue" },
			-- init_options handled in default_config above; you can also pass here if preferred.
			init_options = {
				typescript = {
					tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
				},
			},
		})

		-- TypeScript (required alongside vue_ls). Pick ONE of the two below:

		-- Recommended: vtsls
		-- lspconfig.vtsls.setup({
		-- 	capabilities = capabilities,
		-- 	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
		-- 	init_options = {
		-- 		typescript = {
		-- 			tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
		-- 		},
		-- 	},
		-- })

		-- Alternative: ts_ls (commented out to avoid double-attaching)
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
		})

		-- ESLint
		-- lspconfig.eslint.setup({
		-- 	capabilities = capabilities,
		-- 	settings = { format = { enable = true } },
		-- 	filetypes = { "javascript", "javascriptreact", "typescriptreact", "vue" },
		-- 	on_attach = function(client, bufnr)
		-- 		if vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact" then
		-- 			client.stop()
		-- 		end
		-- 	end,
		-- })

		-- Tailwind CSS
		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
			settings = {
				tailwindCSS = {
					experimental = { classRegex = { "classNames\\(([^)]*)\\)", "tw`([^`]*)`" } },
				},
			},
			filetypes = { "html", "css", "scss", "typescriptreact", "vue", "svelte" },
		})

		-- Lua
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
				},
			},
		})

		-- Others, as you had them
		lspconfig.prismals.setup({ capabilities = capabilities })

		lspconfig.clangd.setup({
			capabilities = capabilities,
			cmd = { "clangd", "--background-index", "--clang-tidy" },
			root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
		})

		lspconfig.cmake.setup({ capabilities = capabilities })
		lspconfig.cssls.setup({ capabilities = capabilities })
		lspconfig.dockerls.setup({ capabilities = capabilities })
		lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
		lspconfig.html.setup({ capabilities = capabilities })
		lspconfig.jsonls.setup({ capabilities = capabilities })
		lspconfig.jdtls.setup({ capabilities = capabilities })
		lspconfig.intelephense.setup({ capabilities = capabilities })
		lspconfig.basedpyright.setup({ capabilities = capabilities })
		lspconfig.lemminx.setup({ capabilities = capabilities })
		lspconfig.glsl_analyzer.setup({ capabilities = capabilities })
	end,
}

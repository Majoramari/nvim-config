return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason = require("mason")
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
			automatic_enable = false,
			ensure_installed = {
				"lua_ls",
				"biome",
				"clangd",
				"cmake",
				"html",
				"angularls",
				"cssls",
				"ts_ls",
				"gopls",
				"zls",
				"bashls",
				"emmet_language_server",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
			},
		})
	end,
}

-- return {
-- 	{
-- 		"williamboman/mason-lspconfig.nvim",
-- 		event = { "BufReadPre", "BufNewFile" },
-- 		dependencies = {
-- 			{
-- 				"williamboman/mason.nvim",
-- 				build = ":MasonUpdate",
-- 				config = true,
-- 			},
-- 		},
-- 		opts = {
-- 			automatic_installation = true,
-- 			automatic_enable = false,
-- 			ensure_installed = {
-- 				"lua_ls",
-- 				"biome",
-- 				"clangd",
-- 				"cmake",
-- 				"html",
-- 				"angularls",
-- 				"cssls",
-- 				"emmet_language_server",
-- 				"zls",
-- 				"bashls",
-- 				"gopls",
-- 			},
-- 		},
-- 	},
--
-- 	-- Better UI for vim.ui.select, vim.ui.input, etc.
-- 	{
-- 		"stevearc/dressing.nvim",
-- 		event = "VeryLazy",
-- 		opts = {},
-- 	},
--
-- 	-- Neovim LSP Config: Configures LSP servers
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		event = { "BufReadPre", "BufNewFile" },
-- 		dependencies = {
-- 			"williamboman/mason-lspconfig.nvim",
-- 			"aznhe21/actions-preview.nvim",
-- 			"MysticalDevil/inlay-hints.nvim",
-- 			{
-- 				"folke/lazydev.nvim",
-- 				ft = "lua",
-- 				opts = {
-- 					library = {
-- 						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
-- 					},
-- 					diagnostics = {
-- 						signs = false,
-- 						underline = false,
-- 						update_in_insert = false,
-- 						severity_sort = true,
-- 						float = {
-- 							border = "rounded",
-- 							source = "always",
-- 						},
-- 					},
-- 				},
-- 			},
-- 		},
-- 		config = function()
-- 			local lspconfig = require("lspconfig")
-- 			local capabilities = require("blink.cmp").get_lsp_capabilities()
--
-- 			local default_opt = {
-- 				capabilities = capabilities,
-- 			}
--
-- 			lspconfig.lua_ls.setup(default_opt)
-- 			lspconfig.biome.setup(default_opt)
-- 			lspconfig.clangd.setup({
-- 				capabilities = capabilities,
-- 				cmd = {
-- 					"clangd",
-- 					"--background-index",
-- 					"--suggest-missing-includes",
-- 					"--header-insertion=never",
-- 					"--compile-commands-dir=build",
-- 				},
-- 			})
-- 			lspconfig.cmake.setup(default_opt)
-- 			lspconfig.html.setup(default_opt)
-- 			lspconfig.angularls.setup({
-- 				capabilities = capabilities,
-- 				root_dir = lspconfig.util.root_pattern("angular.json"),
-- 			})
-- 			lspconfig.cssls.setup(default_opt)
-- 			lspconfig.emmet_language_server.setup(default_opt)
-- 			lspconfig.zls.setup(default_opt)
-- 			lspconfig.bashls.setup(default_opt)
-- 			lspconfig.gopls.setup(default_opt)
--
-- 			vim.diagnostic.config({
-- 				underline = false,
-- 				virtual_text = false,
-- 				update_in_insert = false,
-- 				severity_sort = true,
-- 				float = {
-- 					boarder = "single",
-- 				},
-- 				signs = {
-- 					text = {
-- 						[vim.diagnostic.severity.ERROR] = "",
-- 						[vim.diagnostic.severity.WARN] = "",
-- 						[vim.diagnostic.severity.HINT] = "",
-- 						[vim.diagnostic.severity.INFO] = "",
-- 					},
-- 				},
-- 			})
--
-- 			-- LSP key mappings on attach
-- 			vim.api.nvim_create_autocmd("LspAttach", {
-- 				desc = "LSP actions",
-- 				callback = function(event)
-- 					local buf = event.buf
-- 					local map = vim.keymap.set
--
-- 					map("n", "K", function()
-- 						vim.lsp.buf.hover({ border = "single" })
-- 					end)
-- 					map("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to Definition" })
-- 					map("n", "gD", vim.lsp.buf.declaration, { buffer = buf, desc = "Go to Declaration" })
-- 					map("n", "gi", vim.lsp.buf.implementation, { buffer = buf, desc = "Go to Implementation" })
-- 					map("n", "go", vim.lsp.buf.type_definition, { buffer = buf, desc = "Go to Type Definition" })
-- 					map("n", "gr", vim.lsp.buf.references, { buffer = buf, desc = "Find References" })
-- 					map("n", "ge", function()
-- 						vim.diagnostic.open_float(nil, { border = "single" })
-- 					end, { buffer = buf, desc = "Show Diagnostic" })
-- 					map("n", "<F2>", vim.lsp.buf.rename, { buffer = buf, desc = "Rename" })
-- 				end,
-- 			})
-- 		end,
-- 		keys = {
-- 			{
-- 				"gf",
-- 				function()
-- 					require("actions-preview").code_actions()
-- 				end,
-- 				desc = "Show Code Actions",
-- 				silent = true,
-- 			},
-- 			{
-- 				"<leader>i",
-- 				function()
-- 					vim.cmd("InlayHintsToggle")
-- 				end,
-- 				desc = "Toggle Inlay Hints",
-- 				silent = true,
-- 			},
-- 		},
-- 	},
-- }

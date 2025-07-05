return {
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				build = ":MasonUpdate",
				config = true,
			},
		},
		opts = {
			automatic_installation = true,
			ensure_installed = {
				"lua_ls",
				"biome",
				"clangd",
				"cmake",
				"html",
				"cssls",
				"emmet_ls",
				"zls",
			},
			handlers = {
				function(server_name)
					local nvim_lsp = require("lspconfig")
					local capabilities = require("blink.cmp").get_lsp_capabilities()

					if server_name == "clangd" then
						nvim_lsp.clangd.setup({
							capabilities = capabilities,
							cmd = {
								"clangd",
								"--background-index",
								"--suggest-missing-includes",
								"--header-insertion=never",
								"--compile-commands-dir=build",
								"--clang-tidy",
								"--cache=.out/.cache/clangd",
							},
						})
					else
						nvim_lsp[server_name].setup({
							capabilities = capabilities,
						})
					end
				end,
			},
		},
	},

	-- Better UI for vim.ui.select, vim.ui.input, etc.
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- Neovim LSP Config: Configures LSP servers
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"aznhe21/actions-preview.nvim",
			"MysticalDevil/inlay-hints.nvim",
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
					diagnostics = {
						signs = false,
						underline = false,
						update_in_insert = false,
						severity_sort = true,
						float = {
							border = "rounded",
							source = "always",
						},
					},
				},
			},
		},
		config = function()
			vim.diagnostic.config({
				underline = false,
				virtual_text = false,
				update_in_insert = false,
				severity_sort = true,
				float = {
					boarder = "single",
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "",
						[vim.diagnostic.severity.INFO] = "",
					},
				},
			})

			-- LSP key mappings on attach
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local buf = event.buf
					local map = vim.keymap.set

					map("n", "K", function()
						vim.lsp.buf.hover({ border = "single" })
					end)
					map("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to Definition" })
					map("n", "gD", vim.lsp.buf.declaration, { buffer = buf, desc = "Go to Declaration" })
					map("n", "gi", vim.lsp.buf.implementation, { buffer = buf, desc = "Go to Implementation" })
					map("n", "go", vim.lsp.buf.type_definition, { buffer = buf, desc = "Go to Type Definition" })
					map("n", "gr", vim.lsp.buf.references, { buffer = buf, desc = "Find References" })
					map("n", "ge", function()
						vim.diagnostic.open_float(nil, { border = "single" })
					end, { buffer = buf, desc = "Show Diagnostic" })
					map("n", "<F2>", vim.lsp.buf.rename, { buffer = buf, desc = "Rename" })
				end,
			})
		end,
		keys = {
			{
				"gf",
				function()
					require("actions-preview").code_actions()
				end,
				desc = "Show Code Actions",
				silent = true,
			},
			{
				"<leader>i",
				function()
					vim.cmd("InlayHintsToggle")
				end,
				desc = "Toggle Inlay Hints",
				silent = true,
			},
		},
	},
}

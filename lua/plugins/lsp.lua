return {
	-- Mason LSP Config: Manages LSP server installation
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
			ensure_installed = { "lua_ls", "biome" },
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = require("blink.cmp").get_lsp_capabilities(),
					})
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
						underline = true,
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
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
				virtual_text = {
					source = "always",
					prefix = "➤",
					format = function(diagnostic)
						return diagnostic.message:sub(1, 60) .. (diagnostic.message:len() > 60 and "..." or "")
					end,
				},
				float = {
					source = "if_many",
					border = "rounded",
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- LSP key mappings on attach
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local buf = event.buf
					local map = vim.keymap.set

					map("n", "K", vim.lsp.buf.hover, { buffer = buf, desc = "Hover" })
					map("n", "gd", vim.lsp.buf.definition, { buffer = buf, desc = "Go to Definition" })
					map("n", "gD", vim.lsp.buf.declaration, { buffer = buf, desc = "Go to Declaration" })
					map("n", "gi", vim.lsp.buf.implementation, { buffer = buf, desc = "Go to Implementation" })
					map("n", "go", vim.lsp.buf.type_definition, { buffer = buf, desc = "Go to Type Definition" })
					map("n", "gr", vim.lsp.buf.references, { buffer = buf, desc = "Find References" })
					map("n", "ge", vim.diagnostic.open_float, { buffer = buf, desc = "Show Diagnostic" })
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

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- NOTE: LSP Keybinds

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }
				local map = vim.keymap.set

				-- keymaps

				opts.desc = "Show LSP definitions"
				map("n", "gd", vim.lsp.buf.definition, opts)

				opts.desc = "Go to declaration"
				map("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP implementations"
				map("n", "gi", vim.lsp.buf.implementation, opts)

				opts.desc = "Show LSP type definitions"
				map("n", "gt", vim.lsp.buf.type_definition, opts)

				opts.desc = "Show LSP references"
				map("n", "gr", vim.lsp.buf.references, opts)

				opts.desc = "See available code actions"
				map({ "n", "v" }, "gf", function()
					vim.lsp.buf.code_action()
				end, opts)

				opts.desc = "Smart rename"
				map("n", "<F2>", vim.lsp.buf.rename, opts)

				opts.desc = "Show documentation for what is under cursor"
				map("n", "K", vim.lsp.buf.hover, opts)
			end,
		})

		-- Define sign icons for each severity
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		-- Set the diagnostic config with all icons
		vim.diagnostic.config({
			signs = {
				text = signs, -- Enable signs in the gutter
			},
			virtual_text = false, -- Specify Enable virtual text for diagnostics
			underline = true, -- Specify Underline diagnostics
			update_in_insert = false, -- Keep diagnostics active in insert mode
		})

		-- Setup servers
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- lua_ls
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- emmet_language_server
		lspconfig.emmet_language_server.setup({
			capabilities = capabilities,
			filetypes = {
				"css",
				"eruby",
				"html",
				"javascript",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"pug",
				"typescriptreact",
			},
			init_options = {
				includeLanguages = {},
				excludeLanguages = {},
				extensionsPath = {},
				preferences = {},
				showAbbreviationSuggestions = true,
				showExpandedAbbreviation = "always",
				showSuggestionsAsSnippets = false,
				syntaxProfiles = {},
				variables = {},
			},
		})

		-- -- denols
		-- lspconfig.denols.setup({
		-- 	capabilities = capabilities,
		-- 	root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
		-- })

		-- ts_ls (replaces tsserver)
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			root_dir = function(fname)
				local util = lspconfig.util
				return not util.root_pattern("deno.json", "deno.jsonc")(fname)
					and util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
			end,
			single_file_support = false,
			init_options = {
				preferences = {
					includeCompletionsWithSnippetText = true,
					includeCompletionsForImportStatements = true,
				},
			},
		})

		local default_opt = {
			capabilities = capabilities,
		}

		lspconfig.lua_ls.setup(default_opt)
		lspconfig.biome.setup(default_opt)
		lspconfig.clangd.setup({
			capabilities = capabilities,
			cmd = {
				"clangd",
				"--background-index",
				"--suggest-missing-includes",
				"--header-insertion=never",
				"--compile-commands-dir=build",
			},
		})
		lspconfig.cmake.setup(default_opt)
		lspconfig.html.setup(default_opt)
		lspconfig.angularls.setup({
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern("angular.json"),
		})
		lspconfig.cssls.setup(default_opt)
		lspconfig.zls.setup(default_opt)
		lspconfig.bashls.setup(default_opt)
		lspconfig.gopls.setup(default_opt)
		lspconfig.pyright.setup(default_opt)
		lspconfig.rust_analyzer.setup(default_opt)
	end,
}

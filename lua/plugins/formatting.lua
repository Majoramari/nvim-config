return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				cpp = { "clang-format" },
				cmake = { "gersemi" },
				html = { "prettierd" },
				bash = { "shfmt" },
				python = { "ruff" },
				go = { "goimports", "gofumpt" },
				["javascript"] = { "biome-check" },
				["javascriptreact"] = { "biome-check" },
				["typescript"] = { "biome-check" },
				["typescriptreact"] = { "biome-check" },
				["json"] = { "biome-check" },
				["css"] = { "biome-check" },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>lf", function()
			require("conform").format({
				lsp_format = "fallback",
				async = false,
				timeout_ms = 500,
			})
		end, { noremap = true, silent = true, desc = "Format buffer" })
	end,
}

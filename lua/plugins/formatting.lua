return {
	"stevearc/conform.nvim",
	event = "VeryLazy",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			cpp = { "clang-format" },
			cmake = { "gersemi" },
			html = { "prettierd" },
			css = { "prettierd" },
			bash = { "shfmt" },
			go = { "goimports", "gofumpt" },
		},
	},
	keys = {
		{
			"<C-f>",
			function()
				require("conform").format({
					lsp_format = "fallback",
					async = false,
					timeout_ms = 500,
				})
			end,
			{ mode = { "n", "x" }, noremap = true, silent = true, desc = "Format buffer" },
		},
	},
}

return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			css = { "prettierd" },
		},
	},
	keys = {
		{
			"<C-f>",
			function()
				require("conform").format({
					lsp_format = true,
					async = false,
					timeout_ms = 500,
				})
			end,
			{ mode = { "n", "x" }, noremap = true, silent = true, desc = "Format buffer" },
		},
	},
}

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		{ "rcarriga/nvim-notify", opts = { render = "compact", stages = "slide" } },
	},
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			signature = {
				enabled = false,
			},
		},
	},
	keys = {
		{
			"<localleader>nn",
			"<cmd>NoiceDismiss<CR>",
			silent = true,
			desc = "Dismiss notification",
		},
		{
			"<localleader>nh",
			"<cmd>NoiceHistory<CR>",
			silent = true,
			desc = "Show notifications history",
		},
		{
			"<localleader>nl",
			"<cmd>NoiceHistory<CR>",
			silent = true,
			desc = "Show last notifications",
		},
	},
}

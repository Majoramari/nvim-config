return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		"MunifTanjim/nui.nvim",
		{ "rcarriga/nvim-notify", opts = { render = "compact" } },
	},
	keys = {
		{
			"<leader>nd",
			"<cmd>NoiceDismiss<CR>",
			silent = true,
			desc = "Dismiss notification",
		},
	},
}

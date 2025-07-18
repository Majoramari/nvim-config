return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		{ "rcarriga/nvim-notify", opts = { render = "compact", stages = "slide" } },
	},
	opts = {
		-- lsp = {
		-- 	documentation = {
		-- 		opts = {
		-- 			border = {
		-- 				style = "single",
		-- 			},
		-- 		},
		-- 	},
		-- 	hover = {
		-- 		opts = {
		-- 			border = {
		-- 				style = "single",
		-- 			},
		-- 		},
		-- 	},
		-- },
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

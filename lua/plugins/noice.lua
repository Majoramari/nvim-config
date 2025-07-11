return {
	"folke/noice.nvim",
	event = "VeryLazy",
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
	},
}

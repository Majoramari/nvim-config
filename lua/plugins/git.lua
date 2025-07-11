return {
	{
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		opts = {},
		keys = {
			{ "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
			{ "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
		keys = {
			{
				"<leader>gk",
				"<CMD>Gitsigns preview_hunk_inline<CR>",
				mode = "n",
				noremap = true,
				silent = true,
				desc = "Git Preview hunk inline",
			},
			{
				"<leader>gb",
				"<CMD>Gitsigns blame<CR>",
				mode = "n",
				noremap = true,
				silent = true,
				desc = "Git Blame",
			},
			{
				"<leader>gt",
				function()
					vim.cmd("Gitsigns toggle_current_line_blame")
				end,
				mode = "n",
				noremap = true,
				silent = true,
				desc = "Git Toggle line blame",
			},
		},
	},
}

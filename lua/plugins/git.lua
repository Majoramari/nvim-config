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
				function()
					vim.cmd("Gitsigns preview_hunk")
				end,
				mode = "n",
				noremap = true,
				silent = true,
				desc = "Git Preview hunk",
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

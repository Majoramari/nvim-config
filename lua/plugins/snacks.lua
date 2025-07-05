return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		picker = { enabled = true },
		quickfile = { enabled = true },
		scroll = { enabled = true },
		lazygit = {
			configure = true,
			config = {
				os = { editPreset = "nvim-remote" },
			},
			win = { style = "lazygit" },
		},
	},
	keys = {
		{
			"<leader>gg",
			function()
				local Snacks = require("snacks")
				Snacks.lazygit()
			end,
			mode = "n",
			noremap = true,
			silent = true,
			desc = "Open LazyGit (via snacks.nvim)",
		},
	},
}

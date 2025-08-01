return {
	"akinsho/toggleterm.nvim",
  event = "VeryLazy",
	version = "*",
	opts = {
		open_mapping = [[<c-\>]],
		direction = "float",
		float_opts = {
			border = "rounded",
			winblend = 3,
			highlights = {
				border = "Normal",
				background = "Normal",
			},
		},
	},
}

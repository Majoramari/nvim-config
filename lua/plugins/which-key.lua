return {
	"folke/which-key.nvim",
	event = "VimEnter",
	dependencies = {
		{ "echasnovski/mini.icons", version = "*" },
		{ "nvim-tree/nvim-web-devicons", opts = {} },
	},
	opts = {
		preset = "helix",
		win = {
			border = "rounded",
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}

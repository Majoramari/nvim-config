return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<A-1>",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Select 1st item from Harpoon list",
		},
		{
			"<A-2>",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Select 2nd item from Harpoon list",
		},
		{
			"<A-3>",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Select 3rd item from Harpoon list",
		},
		{
			"<A-4>",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Select 4th item from Harpoon list",
		},
		{
			"<leader>hh",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
			desc = "Toggle Harpoon quick menu",
		},
		{
			"<leader>ha",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add current file to Harpoon list",
		},
	},
}

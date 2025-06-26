-- If removed install this: https://github.com/b0o/incline.nvim
return {
	"romgrk/barbar.nvim",
	version = "^1.0.0",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
		show_icons = true,

		-- Function which formats the tab label
		-- By default surrounds with space and possibly prepends with icon
		format = nil,

		-- Where to show tabpage section in case of multiple vim tabpages.
		-- One of 'left', 'right', 'none'.
		tabpage_section = "left",
	},
}

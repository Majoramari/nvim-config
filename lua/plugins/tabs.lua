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
		format = nil,
		tabpage_section = "left",
	},
	keys = {
		{ "<leader>bp", "<Cmd>BufferPrevious<CR>", desc = "Previous Buffer" },
		{ "<leader>bn", "<Cmd>BufferNext<CR>", desc = "Next Buffer" },
		{ "<leader>br", "<Cmd>BufferRestore<CR>", desc = "Restore Buffer" },
		{ "<leader>bb", "<Cmd>BufferPick<CR>", desc = "Pick Buffer" },
		{ "<leader>bd", "<Cmd>BufferPickDelete<CR>", desc = "Pick & Delete Buffer" },
	},
}

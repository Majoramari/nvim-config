return {
	"MeanderingProgrammer/render-markdown.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
	---@module 'render-markdown'
	opts = {},
}

return {
	"ggandor/leap.nvim",
	dependencies = {
		"tpope/vim-repeat",
	},
	config = function()
		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
	end,
	keys = {
		{
			"<leader>s",
			"<Plug>(leap-forward)",
			desc = "Leap forward",
		},
		{
			"<leader>S",
			"<Plug>(leap-backward)",
			desc = "Leap backward",
		},
	},
}

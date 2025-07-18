return {
	"wakatime/vim-wakatime",
	event = "VeryLazy",
	lazy = false,
	keys = {
		{ "<localleader>ll", "<CMD>WakaTimeToday<CR>", mode = { "n", "v" } },
	},
}

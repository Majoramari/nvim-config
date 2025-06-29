return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy",
	priority = 1000,
	opts = {
		virtual_text = false,
		signs = {
			left = "",
			right = "",
			diag = "●",
			arrow = "    ",
			up_arrow = "    ",
			vertical = " │",
			vertical_end = " └",
		},
		blend = {
			factor = 0.22,
		},
		options = {
			multilines = {
				enabled = true,
				always_show = false,
			},
			break_line = {
				enabled = true,
			},
		},
	},
}

return {
	"mistricky/codesnap.nvim",
	build = "make",
	opts = {
		mac_window_bar = true,
		code_font_family = "JetBrainsMono Nerd Font",
		-- watermark_font_family = "Pacifico",
		watermark = "Made with love by Muhannad",
		bg_theme = "default",
		has_line_number = true,
		min_width = 0,
		bg_x_padding = 122,
		bg_y_padding = 82,
	},
	keys = {
		{ "<S-s>s", ":CodeSnap<CR>", mode = "v", noremap = true, silent = true, desc = "Take a snapshot of your code" },
	},
}

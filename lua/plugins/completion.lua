return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	event = { "BufReadPre", "BufNewFile" },
	version = "1.*",
	opts = {
		keymap = { preset = "default" },

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		completion = {
			ghost_text = {
				enabled = true,
			},
			menu = {
				enabled = true,
				border = "single",
			},
			-- documentation = {
			-- 	auto_show = true,
			--      window = {
			--        border = "single",
			--      }
			-- },
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
	opts_extend = { "sources.default" },
}

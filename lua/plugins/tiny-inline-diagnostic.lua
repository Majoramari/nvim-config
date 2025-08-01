return {
	"rachartier/tiny-inline-diagnostic.nvim",
  lazy = false,
	priority = 1000,
	opts = {
		preset = "amongus",
		virtual_text = true,
		hi = {
			error = "DiagnosticError", -- Highlight group for error messages
			warn = "DiagnosticWarn", -- Highlight group for warning messages
			info = "DiagnosticInfo", -- Highlight group for informational messages
			hint = "DiagnosticHint", -- Highlight group for hint or suggestion messages
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

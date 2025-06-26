local spec = { "catppuccin/nvim" }

spec.name = "catppuccin"
spec.enabled = true
spec.lazy = true
spec.event = { "VeryLazy" }
spec.priority = 1000 -- high priority to apply theme early

spec.opts = {
	transparent_background = true,
	integrations = {
		mini = true,
		notify = true,
		telescope = true,
		treesitter = true,
		which_key = true,
	},
}

return spec

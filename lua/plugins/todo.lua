-- PERF: fully optimized
-- HACK: hmmm, this looks a bit funky
-- TODO: What else?
-- NOTE: Adding a note
-- FIX: This needs fix
-- WARNING: ???
return {
	"folke/todo-comments.nvim",
	event = { "BufRead", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--glob=!node_modules",
			},
			pattern = [[\b(KEYWORDS):]],
		},
	},
	keys = {
		{
			"<leader>fl",
			":TodoTelescope<CR>",
			desc = "Find todo-comments",
			noremap = true,
			silent = true,
		},
	},
}

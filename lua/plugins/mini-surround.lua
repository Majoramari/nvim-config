return {
	"echasnovski/mini.surround",
	event = { "BufReadPre", "BufNewFile" },
	version = false,
	opts = {
		n_lines = 100,
		mappings = {
			add = "sa", -- Add surrounding in Normal and Visual modes
			delete = "sd", -- Delete surrounding
			find = "sf", -- Find surrounding (to the right)
			find_left = "sF", -- Find surrounding (to the left)
			highlight = "sh", -- Highlight surrounding
			replace = "sr", -- Replace surrounding
			update_n_lines = "sn", -- Update `n_lines`

			suffix_last = "p", -- Suffix to search with "prev" method
			suffix_next = "n", -- Suffix to search with "next" method
		},
		search_method = "cover_or_next",
	},
}

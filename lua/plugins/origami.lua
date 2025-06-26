return {
	"chrisgrieser/nvim-origami",
  event = { "BufReadPre", "BufNewFile" },
	init = function()
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
	end,
	opts = {
		useLspFoldsWithTreesitterFallback = true,
		pauseFoldsOnSearch = true,
		foldtext = {
			enabled = true,
			padding = 3,
			lineCount = {
				template = "󰁂 %d",
				hlgroup = "Comment",
			},
			diagnosticsCount = true,
			gitsignsCount = true,
		},
		autoFold = {
			enabled = true,
			kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
		},
		foldKeymaps = {
			setup = true,
			hOnlyOpensOnFirstColumn = false,
		},
	},
}

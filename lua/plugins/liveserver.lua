return {
	"barrett-ruth/live-server.nvim",
	build = "pnpm add -g live-server",
	cmd = { "LiveServerStart", "LiveServerStop" },
	ft = {
		"html",
		"css",
		"javascript",
		"typescript",
		"vue",
		"svelte",
	},
	config = function()
		require("live-server").setup({
			port = 5555,
		})
	end,
	keys = {
		{
			"<localleader>lr",
			function()
				vim.cmd("LiveServerStart")
				vim.fn.jobstart({ "xdg-open", "http://localhost:5555" }, { detach = true })
				vim.notify("Live Server started at http://localhost:5555", vim.log.levels.INFO)
			end,
			desc = "Start Live Server",
			silent = true,
			ft = { "html", "css", "javascript", "typescript", "vue", "svelte" },
		},
		{
			"<localleader>ls",
			function()
				vim.cmd("LiveServerStop")
				vim.notify("Live Server stopped", vim.log.levels.WARN)
			end,
			desc = "Stop Live Server",
			silent = true,
			ft = { "html", "css", "javascript", "typescript", "vue", "svelte" },
		},
	},
}

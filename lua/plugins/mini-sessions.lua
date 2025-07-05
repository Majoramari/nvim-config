return {
	"echasnovski/mini.sessions",
	version = false,
	event = "VeryLazy", -- lazy load after startup
	opts = {
		autoread = false, -- set to true if you want auto-load
		autowrite = true, -- enable auto-save when quitting
	},
	config = function(_, opts)
		require("mini.sessions").setup(opts)

		-- Automatically write session on exit
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				local mini_sessions = require("mini.sessions")
				mini_sessions.write(nil, { force = true }) -- writes to current session
			end,
		})
	end,
}

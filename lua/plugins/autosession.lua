return {
	"pysan3/autosession.nvim",
	event = { "VeryLazy" },
	dependencies = { "mhinz/vim-startify" },
	opts = {
		autosave_on_quit = true,
	},
	keys = {
		{ "<localleader>sh", "<CMD>AutoSession<CR>", desc = "AutoSession: Show help" },
		{ "<localleader>sr", "<CMD>AutoSessionRestore<CR>", desc = "Restore previous session" },
		{ "<localleader>ss", "<CMD>AutoSessionSave<CR>", desc = "Save current session" },
		{ "<localleader>sa", "<CMD>AutoSessionAuto<CR>", desc = "Auto-update session if exists" },
		{ "<localleader>sg", "<CMD>AutoSessionGlobal<CR>", desc = "Register global session" },
		{ "<localleader>sd", "<CMD>AutoSessionDelete<CR>", desc = "Delete global session" },
	},
}

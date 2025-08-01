vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	callback = function()
		vim.hl.on_yank()
	end,
})

-- local autosave_timer = nil
-- local debounce_delay = 1500
--
-- local function schedule_autosave()
-- 	if autosave_timer then
-- 		vim.fn.timer_stop(autosave_timer)
-- 	end
--
-- 	autosave_timer = vim.fn.timer_start(debounce_delay, function()
-- 		if vim.bo.modified and vim.bo.modifiable and vim.bo.buftype == "" then
-- 			vim.cmd("silent! write")
-- 			vim.notify("💾 Auto-saved at " .. vim.fn.strftime("%H:%M:%S"), vim.log.levels.INFO)
-- 		end
-- 	end)
-- end
--
-- vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
-- 	pattern = "*",
-- 	callback = schedule_autosave,
-- })

-- C++/C
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "cmake", "CMakeLists.txt" },
	callback = function()
		vim.api.nvim_set_keymap(
			"n",
			"<Leader>cr",
			":CMakeRun<CR>",
			{ noremap = true, silent = true, desc = "Run CMake" }
		)
	end,
})

local Terminal = require("toggleterm.terminal").Terminal

-- Shared terminal for `cargo run`
local run_term = Terminal:new({
	direction = "horizontal",
	hidden = true,
	close_on_exit = false,
})

local function cargo_run()
	if not run_term:is_open() then
		run_term:open()
	end
	run_term:send("clear && cargo run\n", false)
end

-- Function to create a new temporary terminal for other cargo commands
local function cargo_exec_temp(cmd)
	local temp = Terminal:new({
		cmd = "cargo " .. cmd,
		direction = "float",
		close_on_exit = true,
		hidden = true,
	})
	temp:toggle()
end

-- Autocmd to set up keymaps for Rust
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		-- Run: Reuses shared terminal
		vim.keymap.set("n", "<localleader>cr", cargo_run, { buffer = true, desc = "Cargo Run" })

		-- Build/Test/Clean: Each opens a new terminal
		vim.keymap.set("n", "<localleader>cb", function()
			cargo_exec_temp("build")
		end, { buffer = true, desc = "Cargo Build" })

		vim.keymap.set("n", "<localleader>ct", function()
			cargo_exec_temp("test")
		end, { buffer = true, desc = "Cargo Test" })

		vim.keymap.set("n", "<localleader>cc", function()
			cargo_exec_temp("clean")
		end, { buffer = true, desc = "Cargo Clean" })
	end,
})

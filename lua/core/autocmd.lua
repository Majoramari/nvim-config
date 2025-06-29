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

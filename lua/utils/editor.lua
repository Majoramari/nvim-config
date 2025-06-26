local M = {}

-- Line length guide functionality
function M.setup_line_guide()
	M.wrap_guide_limit = "110"

	function M.toggle_wrap_guide()
		vim.wo.colorcolumn = vim.wo.colorcolumn == M.wrap_guide_limit and "" or M.wrap_guide_limit
	end

	-- Set keymap (guide starts disabled by default)
	vim.keymap.set("n", "<F9>", M.toggle_wrap_guide, {
		desc = "Toggle line length guide",
		noremap = true,
		silent = true,
	})
end

return M

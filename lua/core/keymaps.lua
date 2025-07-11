local map = vim.keymap.set

-- Set leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

----------------------------------------
--- Core Editing & Text Manipulation
----------------------------------------
-- map("n", "<C-a>", "ggVG", { desc = "Select entire buffer", noremap = true, silent = true })
map("i", "<C-e>", "<C-o>dW", { desc = "Delete next word", noremap = true, silent = true })

----------------------------------------
--- Clipboard Operations
----------------------------------------
local clipboard_opts = { noremap = true, silent = true }
-- Yank to system clipboard
map({ "n", "v" }, "<leader>y", '"+y', vim.tbl_extend("force", clipboard_opts, { desc = "Yank to system clipboard" }))
map("n", "<leader>Y", '"+Y', vim.tbl_extend("force", clipboard_opts, { desc = "Yank line to clipboard" }))
-- Paste from system clipboard
map({ "n", "v" }, "<leader>p", '"+p', vim.tbl_extend("force", clipboard_opts, { desc = "Paste from system clipboard" }))
map(
	{ "n", "v" },
	"<leader>P",
	'"+P',
	vim.tbl_extend("force", clipboard_opts, { desc = "Paste from system clipboard (before)" })
)
-- Delete without yanking
map("n", "x", '"_x', { desc = "Delete character without yank", noremap = true, silent = true })
map({ "n", "v" }, "<leader>d", '"_d', vim.tbl_extend("force", clipboard_opts, { desc = "Delete without yank" }))
-- Visual paste without yanking
map("x", "p", '"_dP', vim.tbl_extend("force", clipboard_opts, { desc = "Paste without yanking in visual mode" }))

----------------------------------------
--- Tab Management
----------------------------------------
local tab_opts = { noremap = true, silent = true }
map("n", "te", ":tabedit<CR>", vim.tbl_extend("force", tab_opts, { desc = "New tab" }))
map("n", "<Tab>", ":tabnext<CR>", vim.tbl_extend("force", tab_opts, { desc = "Next tab" }))
map("n", "<S-Tab>", ":tabprev<CR>", vim.tbl_extend("force", tab_opts, { desc = "Previous tab" }))
map("n", "tw", ":tabclose<CR>", vim.tbl_extend("force", tab_opts, { desc = "Close tab" }))

----------------------------------------
--- File & Buffer Operations
----------------------------------------
local file_opts = { noremap = true, silent = true }
map("n", "<leader>w", ":update<CR>", vim.tbl_extend("force", file_opts, { desc = "Save file" }))
map("n", "<leader>q", ":quit<CR>", vim.tbl_extend("force", file_opts, { desc = "Quit window" }))
map("n", "<leader>Q", ":qa<CR>", vim.tbl_extend("force", file_opts, { desc = "Quit all" }))
map("n", "<leader>bd", ":bd<CR>", vim.tbl_extend("force", file_opts, { desc = "Delete buffer" }))

----------------------------------------
--- Navigation & Search
----------------------------------------
local nav_opts = { noremap = true, silent = true }
map("n", "<C-d>", "<C-d>zz", vim.tbl_extend("force", nav_opts, { desc = "Scroll down centered" }))
map("n", "<C-u>", "<C-u>zz", vim.tbl_extend("force", nav_opts, { desc = "Scroll up centered" }))
map("n", "n", "nzzzv", vim.tbl_extend("force", nav_opts, { desc = "Next match centered" }))
map("n", "N", "Nzzzv", vim.tbl_extend("force", nav_opts, { desc = "Previous match centered" }))
map("n", "H", "^", { noremap = true, silent = true, desc = "Go to first non-blank character" })

----------------------------------------
--- Quickfix
----------------------------------------
map({ "n", "v" }, "<localleader>qq", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local info = vim.fn.getwininfo(win)[1]
		if info and info.quickfix == 1 then
			return vim.cmd("cclose")
		end
	end
	if #vim.fn.getqflist() > 0 then
		return vim.cmd("botright copen")
	end
	print("Quickfix list is empty")
end, { noremap = true, silent = true, desc = "Toggle Quickfix List" })
map({ "n", "v" }, "<localleader>e", "<CMD>cnext<CR>zz", { noremap = true, silent = true, desc = "Quickfix Next" })
map({ "n", "v" }, "<localleader>w", "<CMD>cprev<CR>zz", { noremap = true, silent = true, desc = "Quickfix Previous" })
map({ "n", "v" }, "<localleader>qC", "<CMD>cexpr []<CR>", {
	noremap = true,
	silent = true,
	desc = "Clear Quickfix List",
})
map({ "n", "v" }, "<localleader>qe", "<CMD>cnewer<CR>", {
	noremap = true,
	silent = true,
	desc = "Quickfix Next List",
})
map({ "n", "v" }, "<localleader>qw", "<CMD>colder<CR>", {
	noremap = true,
	silent = true,
	desc = "Quickfix Previous List",
})

----------------------------------------
--- Quality of Life Improvements
----------------------------------------
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear search highlights" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "Exit terminal mode" })

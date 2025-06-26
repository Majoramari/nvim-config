local o = vim.opt

----------------------------------------
--- Core Configuration
----------------------------------------
o.encoding = "utf-8"
o.fileencoding = "utf-8"

----------------------------------------
--- Interface & Display
----------------------------------------
o.number = true -- Show line numbers
o.relativenumber = true -- Relative line numbers
o.cursorline = false -- Highlight current line
o.signcolumn = "yes" -- Always show sign column
o.termguicolors = true -- 24-bit RGB colors
o.splitbelow = true -- New horizontal splits below
o.splitright = true -- New vertical splits right
o.splitkeep = "cursor" -- Maintain cursor position when splitting
o.scrolloff = 5 -- Minimum lines above/below cursor
o.sidescrolloff = 5 -- Minimum columns beside cursor
o.wrap = false -- Disable line wrapping

----------------------------------------
--- Editing Behavior
----------------------------------------
o.expandtab = true -- Convert tabs to spaces
o.tabstop = 2 -- Spaces per TAB character
o.softtabstop = -1 -- Spaces per TAB in insert mode
o.shiftwidth = 2 -- Spaces per indent level
o.autoindent = true -- Maintain current indent
o.smartindent = true -- Context-aware indentation
o.breakindent = true -- Maintain indent on wrapped lines
o.backspace = { "start", "eol", "indent" } -- Full backspace functionality
o.formatoptions:append("r") -- Auto-add asterisks in block comments
o.conceallevel = 0 -- Show formatted text (e.g. markdown)

----------------------------------------
--- Search & Matching
----------------------------------------
o.hlsearch = true -- Highlight search matches
o.incsearch = true -- Show partial match while typing
o.ignorecase = true -- Case-insensitive search
o.smartcase = true -- Case-sensitive when uppercase present
o.inccommand = "split" -- Show replace preview in split

----------------------------------------
--- Performance & Files
----------------------------------------
o.backup = false -- No backup files
o.swapfile = false -- No swap files
o.undofile = true -- Persistent undo history
o.updatetime = 300 -- Faster CursorHold events (ms)
vim.opt.wildignore = {
	"*/node_modules/*",
	"*/dist/*",
	"*/build/*",
	"*/target/*",
	"*/vendor/*",
	"*/coverage/*",
	"*/.git/*",
	"*/.hg/*",
	"*/.svn/*", -- Version control
	"*.o",
	"*.obj",
	"*.bin",
	"*.dll",
	"*.exe",
	"*.pyc", -- Compiled binaries
	"*.png",
	"*.jpg",
	"*.jpeg",
	"*.gif",
	"*.pdf", -- Media files
}
o.path:append("**") -- Search subdirectories

----------------------------------------
--- Advanced & Plugin Readiness
----------------------------------------
o.completeopt = "menu,menuone,noselect" -- Better completion UX
o.smarttab = true -- Tab respects shiftwidth
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.python3_host_prog = vim.fn.expand("~/.pyenv/versions/neovim/bin/python")
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand("~/.pyenv/versions/neovim/bin")

-- Utils
require("utils.editor").setup_line_guide()

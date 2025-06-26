local M = {}

function M.setup()
  local theme_file = vim.fn.stdpath("config") .. "/theme.txt"
  if vim.fn.filereadable(theme_file) == 1 then
    local theme = vim.fn.readfile(theme_file)[1]
    pcall(vim.cmd.colorscheme, theme)
  else
    -- Fallback theme
    pcall(vim.cmd.colorscheme, "catppuccin")
  end
end

return M

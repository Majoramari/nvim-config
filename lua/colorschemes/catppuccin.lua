return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    transparent_background = true,
    integrations = {
      mini = true,
      notify = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    }
  }
}

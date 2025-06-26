return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  event = { "BufReadPre", "BufNewFile" },
  version = "1.*",
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },

    completion = {
      ghost_text = {
        enabled = true
      },
      documentation = { auto_show = false }
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

  },
  opts_extend = { "sources.default" },
}

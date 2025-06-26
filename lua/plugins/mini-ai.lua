return {
  "echasnovski/mini.ai",
  keys = {
    { "a", mode = { "x", "o" } }, -- Trigger for outer text objects
    { "i", mode = { "x", "o" } }, -- Trigger for inner text objects
  },
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      init = function()
        -- Only need queries, not full plugin
        require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
      end,
    },
  },
  opts = function()
    local ai = require("mini.ai")
    return {
      n_lines = 500,
      custom_textobjects = {
        -- Extended text objects for blocks/conditionals/loops
        o = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }, {}),

        -- Function text objects
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),

        -- Class text objects
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        mappings = {
          -- Main textobject prefixes
          around = 'a',
          inside = 'i',

          -- Next/last variants
          around_next = 'an',
          inside_next = 'in',
          around_last = 'ap',
          inside_last = 'ip',
        },
      },
    }
  end,
  config = function(_, opts)
    require("mini.ai").setup(opts)
  end,
}

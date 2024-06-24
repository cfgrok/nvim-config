return {
  {
    "abecodes/tabout.nvim",
    event = "VeryLazy",
    -- init = function()
    --   require("tabout.config").debug = true
    -- end,
    opts = {
      act_as_shift_tab = true,
      ignore_beginning = true,
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
        { open = "<", close = ">" },
        { open = "|", close = "|" },
      },
    },
    dependencies = {
      "hrsh7th/nvim-cmp",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<c-tab>", "<Plug>(TaboutMulti)", mode = "i", desc = "Tab out from pairs" },
      { "<c-s-tab>", "<Plug>(TaboutBackMulti)", mode = "i", desc = "Tab backwards out from pairs" },
    },
  },
}

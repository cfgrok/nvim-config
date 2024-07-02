return {
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter" },
    opts = {
      max_join_length = 500,
      on_error = function() require("mini.splitjoin").toggle() end,
      use_default_keymaps = false,
    },
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Split/Join" } },
  },
}

return {
  -- Make sure buffer pin icon appears
  {
    "bufferline.nvim",
    opts = {
      options = {
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with({ icon = "" }),
          },
        },
      },
    },
  },
  -- Disable treesitter-context by default -- manually enable to use
  {
    "nvim-treesitter-context",
    opts = {
      enable = false,
    },
  },
}

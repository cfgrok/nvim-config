return {
  -- Increase timeout on notifications
  {
    "nvim-notify",
    opts = {
      timeout = 5000,
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

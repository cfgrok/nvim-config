return {
  -- Add snippet filetypes
  {
    "nvim-snippets",
    event = "VeryLazy",
    opts = {
      extended_filetypes = {
        cf = { "html", "javascript" },
        eruby = { "html" },
      },
    },
  },
}

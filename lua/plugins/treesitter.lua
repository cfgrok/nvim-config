return {
  {
    "nvim-treesitter",
    opts = {
      ensure_installed = {
        "comment",
        "css",
        "csv",
        "dockerfile",
        "embedded_template",
        "graphql",
        "htmldjango",
        "ruby",
        "tsv",
      },
      textobjects = {
        swap = {
          enable = true,
          swap_next = { ["<leader>cp"] = { "@parameter.inner", desc = "Swap next parameter" } },
          swap_previous = { ["<leader>cP"] = { "@parameter.inner", desc = "Swap previous parameter" } },
        },
      },
    },
  },
}

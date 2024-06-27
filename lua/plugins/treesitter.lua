return {
  {
    "nvim-treesitter",
    dependencies = { "RRethy/nvim-treesitter-endwise" },
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
      endwise = { enable = true },
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

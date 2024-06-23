return {
  {
    "nvim-lint",
    opts = {
      linters_by_ft = {
        eruby = { "erb_lint" },
      },
      linters = {
        erb_lint = {
          cmd = "erblint",
          args = { "--format", "compact" },
        },
      },
    },
  },
}

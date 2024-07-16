return {
  {
    "conform.nvim",
    opts = {
      formatters = {
        erb_format = {
          inherit = false,
          command = "erb-format",
          args = { "--stdin", "--print-width", "120" },
        },
      },
      formatters_by_ft = {
        eruby = { "erb_format" },
      },
    },
  },
}

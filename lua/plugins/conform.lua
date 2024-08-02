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
        rubocop = {
          command = "bundle",
          args = {
            "exec",
            "rubocop",
            "-A",
            "-f",
            "quiet",
            "--stderr",
            "--stdin",
            "$FILENAME",
          },
        },
      },
      formatters_by_ft = {
        eruby = { "erb_format" },
        ruby = { "rubocop" },
      },
    },
  },
}

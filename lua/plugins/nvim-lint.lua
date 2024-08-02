return {
  {
    "nvim-lint",
    opts = {
      linters_by_ft = {
        eruby = { "erb_lint" },
        -- ruby = { "rubocop" },
      },
      linters = {
        -- rubocop = {
        --   stdin = true,
        --   cmd = "bundle",
        --   args = {
        --     "exec",
        --     "rubocop",
        --     "--format",
        --     "json",
        --     "--force-exclusion",
        --     -- "--server",
        --     "--stdin",
        --     function() return vim.api.nvim_buf_get_name(0) end,
        --   },
        -- },
      },
    },
  },
}

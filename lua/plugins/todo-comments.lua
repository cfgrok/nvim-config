return {
  -- FIX: This is a test
  -- WARN: This is a test
  -- HACK: This is a test
  -- NOTE: This is a test
  -- TODO: This is a test
  -- PERF: This is a test
  -- TEST: This is a test
  {
    "todo-comments.nvim",
    opts = {
      keywords = {
        TODO = { icon = " " },
        FIX = { icon = " " },
        WARN = { icon = " ", color = "warn" },
        HACK = { icon = " " },
        PERF = { icon = " ", color = "perf" },
        NOTE = { icon = " 󰎛" },
        TEST = { icon = " 󰇉", color = "perf" },
      },
      colors = {
        perf = { "diffOldFile", "#268BD3" },
        warn = { "WarningMsg", "#B28500" },
      },
    },
  },
}

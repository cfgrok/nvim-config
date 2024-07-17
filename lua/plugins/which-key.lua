return {
  {
    "which-key.nvim",
    opts = function(_, opts)
      opts = vim.tbl_deep_extend("force", opts, {
        preset = "modern",
        plugins = {
          presets = {
            windows = false,
          },
        },
        win = { no_overlap = false },
        sort = { "order", "group", "alphanum" },
        icons = { mappings = false },
      })

      table.insert(opts.spec, {
        mode = { "n", "v" },
        { "<leader>", group = "leader" },
        { "<leader>j", group = "join/split/misc" },
        { "<a-w>", group = "window" },
        { "<c-w>", desc = "Delete Buffer" },
        { "<c-w><c-d>", hidden = true },
        { "<c-w>d", hidden = true },
        { "<c-z>", group = "emmet" },
        { "g", group = "goto/misc" },
        { "H", desc = "Start of line" },
        { "L", desc = "End of line" },
        { "'", desc = "Marks" },
        { "g`", desc = "Marks" },
        { "g'", desc = "Marks" },
        { '"', desc = "Registers" },
      })

      return opts
    end,
  },
}

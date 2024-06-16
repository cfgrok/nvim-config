return {
  -- Customize flash highlighting
  {
    "flash.nvim",
    opts = {
      highlight = {
        groups = {
          current = "NeogitHunkHeaderHighlight",
          label = "NeogitDiffDeleteHighlight",
          match = "NeogitDiffAddHighlight",
        },
      },
      modes = {
        char = {
          search = { wrap = true },
          label = {
            style = "overlay",
            current = false,
            after = false,
            before = false,
            distance = false,
          },
          highlight = {
            groups = {
              label = "NeogitDiffAddHighlight", -- :hi for f/F
              match = "NeogitDiffAddHighlight", -- :hi for t/T
            },
          },
        },
      },
    },
  },
  {
    "which-key.nvim",
    opts = {
      defaults = {
        -- Define missing which-key descriptions
        [";"] = "Jump to next f/F/t/T match",
        [","] = "Jump to previous f/F/t/T match",
      },
    },
  },
}

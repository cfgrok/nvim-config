return {
  -- Customize telescope layout and sorting
  {
    "telescope.nvim",
    opts = {
      defaults = {
        layout_config = {
          horizontal = {
            preview_width = 0.6,
            prompt_position = "top",
            width = 0.9,
          },
        },
        sorting_strategy = "ascending",
      },
    },
  },
}

return {
  -- Customize telescope layout and sorting
  {
    "telescope.nvim",
    opts = function(_, opts)
      require("telescope").load_extension("persisted")
      local defaults = {
        layout_config = {
          horizontal = {
            preview_width = 0.6,
            prompt_position = "top",
            width = 0.9,
          },
        },
        sorting_strategy = "ascending",
      }
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, defaults)
      return opts
    end,
  },
}

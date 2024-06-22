return {
  -- Install rainbow delimiter highlighting
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    enabled = true,
    main = "rainbow-delimiters.setup",
    init = function()
      -- Autocommand to disable delimiters in HTML files by default
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "html" },
        group = vim.api.nvim_create_augroup("rainbow_delimiters", { clear = true }),
        callback = function()
          require("rainbow-delimiters").disable(0)
        end,
      })
    end,
    -- Configuration placeholder
    opts = {},
    keys = {
      {
        "<leader>ur",
        function()
          require("rainbow-delimiters").toggle(0)
        end,
        desc = "Toggle Rainbow Delimiters",
      },
    },
  },
}

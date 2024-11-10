return {
  -- Install rainbow delimiter highlighting
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    init = function()
      local rb = require("rainbow-delimiters")

      -- Autocommand to disable delimiters in HTML files by default
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("rainbow_delimiters", { clear = true }),
        pattern = { "html" },
        callback = function() rb.disable(0) end,
      })

      -- Rainbow delimiters toggle keymapping -- needed to use defer_fn for toggle to execute
      vim.defer_fn(function()
        Snacks.toggle({
          name = "Rainbow Delimiters",
          get = function() return rb.is_enabled(0) end,
          set = function() rb.toggle(0) end,
        }):map("<leader>ur")
      end, 500)
    end,
  },
}

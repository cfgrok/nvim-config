return {
  {
    "levouh/tint.nvim",
    event = "VeryLazy",
    opts = {
      tint = -20,
      saturation = 0.4,
    },
    config = function(_, opts)
      local tint = require("tint")
      tint.setup(opts)

      -- Disable tint by default and use autocmd to manually tint/untint windows
      LazyVim.on_load("tint.nvim", function() tint.disable() end)

      vim.g.last_active_window = 1000

      vim.api.nvim_create_autocmd("WinEnter", {
        group = vim.api.nvim_create_augroup("toggle_tint", { clear = true }),
        callback = function()
          local win = vim.api.nvim_get_current_win()
          local qf_open = vim.g.qf_open
          vim.schedule(function()
            if not qf_open and Is_normal_buffer(win) then vim.g.last_active_window = win end
            local wins = vim.api.nvim_list_wins()
            for _, w in pairs(wins) do
              if w ~= win and Is_normal_buffer(w) then tint.tint(w) end
            end
            tint.untint(vim.g.last_active_window)
          end)
        end,
      })
    end,
  },
}

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
      LazyVim.on_load("tint.nvim", function() tint.disable() end)
    end,
  },
}

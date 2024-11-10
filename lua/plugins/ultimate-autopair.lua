return {
  {
    "altermo/ultimate-autopair.nvim",
    event = "VeryLazy",
    branch = "v0.6",
    opts = {
      cmap = false,
      pair_cmap = false,
      tabout = { enable = true, hopout = true, map = "<c-;>" },
      { "|", "|", suround = true, ft = { "eruby", "ruby" } },
      { "#", "#", suround = true, ft = { "cf" } },
      { "<%", "%>", space = true, newline = true, ft = { "eruby", "html" } },
      { "<%=", "%>", space = true, newline = true, ft = { "eruby", "html" } },
      { "<%#", "%>", space = true, newline = true, ft = { "eruby", "html" } },
    },
    config = function(_, opts)
      local ua = require("ultimate-autopair")
      ua.setup(opts)

      -- Ultimate Autopair toggle keymapping
      Snacks.toggle({
        name = "Ultimate Autopair",
        get = function() return ua.isenabled() end,
        set = function() ua.toggle() end,
      }):map("<leader>up")
    end,
  },
}

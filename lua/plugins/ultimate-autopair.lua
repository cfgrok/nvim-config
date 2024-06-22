return {
  {
    "altermo/ultimate-autopair.nvim",
    enabled = true,
    event = { "InsertEnter", "CmdlineEnter" },
    branch = "v0.6",
    opts = {
      cmap = false,
      pair_cmap = false,
      tabout = { enable = true, hopout = true, map = "<c-;>" },
      { "#", "#", suround = true, ft = { "cf" } },
      { "<%", "%>", space = true, newline = true, ft = { "html" } },
      { "<%=", "%>", space = true, newline = true, ft = { "html" } },
      { "<%#", "%>", space = true, newline = true, ft = { "html" } },
    },
    keys = {
      {
        "<leader>up",
        function()
          local ua = require("ultimate-autopair")
          ua.toggle()
          if ua.isenabled() then
            LazyVim.info("ultimate-autopair enabled", { title = "Autopairs" })
          else
            LazyVim.warn("ultimate-autopair disabled", { title = "Autopairs" })
          end
        end,
        desc = "Toggle ultimate-autopair",
      },
    },
  },
}

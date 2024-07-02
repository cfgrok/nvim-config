return {
  {
    "dashboard-nvim",
    opts = function(_, opts)
      local lolcat = vim.fn.executable("lolcat") == 1
      local logo_path = vim.fn.stdpath("config") .. "/cfgrok_logo.txt"
      local logo = vim.fn.readfile(logo_path)
      table.insert(logo, 1, "")
      table.insert(logo, 1, "")
      table.insert(logo, "")
      table.insert(logo, "")
      opts.config.header = (not lolcat) and logo
      opts.preview = lolcat
          and {
            command = "cat | lolcat -p 1.3",
            file_path = logo_path,
            file_width = 88,
            file_height = 10,
          }
        or {}
      opts.config.center[6] = {
        action = "Telescope persisted",
        desc = " Select Session",
        icon = " ",
        key = "s",
        key_format = "  %s",
      }
    end,
  },
}

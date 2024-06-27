return {
  -- Lualine customization
  {
    "lualine.nvim",
    opts = function(_, opts)
      table.remove(opts.sections.lualine_c, 3)
      table.insert(opts.sections.lualine_c, 3, {
        "filetype",
        separator = "",
        padding = { left = 1, right = 0 },
        icon = { align = "right" },
      })
      table.insert(opts.sections.lualine_c, 4, {
        "fileformat",
        separator = "",
        icons_enabled = false,
        color = "lualine_a_replace",
        cond = function()
          return vim.bo.fileformat ~= "unix"
        end,
      })
      table.insert(opts.sections.lualine_c, 5, {
        "encoding",
        separator = "",
        color = "lualine_a_replace",
        cond = function()
          return vim.bo.fileencoding ~= "utf-8"
        end,
      })
    end,
  },
  {
    "noice.nvim",
    opts = {
      lsp = {
        signature = {
          auto_open = {
            enabled = false,
          },
        },
      },
    },
  },
  -- Increase timeout on notifications
  {
    "nvim-notify",
    opts = {
      timeout = 5000,
    },
  },
  -- Disable treesitter-context by default -- manually enable to use
  {
    "nvim-treesitter-context",
    opts = {
      enable = false,
    },
  },
}

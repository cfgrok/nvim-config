return {
  -- Lualine customization
  {
    "lualine.nvim",
    opts = function(_, opts)
      local util = require("lazyvim.util")

      opts.sections.lualine_c[3] = {
        "filetype",
        icon = { align = "right" },
        padding = { left = 1, right = 0 },
        separator = "",
      }
      table.insert(opts.sections.lualine_c, 4, {
        "fileformat",
        color = "lualine_a_replace",
        cond = function()
          return vim.bo.fileformat ~= "unix"
        end,
        icons_enabled = false,
        separator = "",
      })
      table.insert(opts.sections.lualine_c, 5, {
        "encoding",
        color = "lualine_a_replace",
        cond = function()
          return vim.bo.fileencoding ~= "utf-8"
        end,
        separator = "",
      })
      opts.sections.lualine_c[6] = {
        util.lualine.pretty_path({ modified_hl = "ModifiedFile" }),
      }

      table.remove(opts.sections.lualine_y, 1)
      opts.sections.lualine_y[1] = {
        "location",
        padding = { left = 0, right = 1 },
      }

      opts.sections.lualine_z[1] = {
        "progress",
        padding = { left = 1, right = 0 },
        separator = "",
      }
      table.insert(opts.sections.lualine_z, { "%L" })
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
      stages = "fade_in_slide_out",
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

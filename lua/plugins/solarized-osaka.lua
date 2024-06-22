return {
  -- Install & configure solarized-osaka theme
  {
    "craftzdog/solarized-osaka.nvim",
    branch = "main",
    lazy = false,
    priority = 1000,
    opts = function()
      local hsl = require("solarized-osaka.hsl").hslToHex
      local darken = require("solarized-osaka.util").darken

      -- Foreground for comments between the base0 and base00 colors
      local commentfg = hsl(190, 8, 50)

      return {
        transparent = true,
        on_colors = function(c)
          -- Lighter background for all float and sidebar elements
          c.bg_float = c.base03
          c.bg_sidebar = c.base03
        end,
        on_highlights = function(hl, c)
          -- Brighter comments for better contrast with transparent background
          hl.Comment = { fg = commentfg }

          -- Brighter line numbers with a contrasting current line number and
          -- no cursorline background
          hl.CursorLine = { bg = c.none }
          hl.CursorLineNr = { fg = c.red }
          hl.LineNr = { fg = c.yellow500 }

          -- Change to less distracting color for pair matching
          hl.MatchParen = { fg = c.red500, bg = c.red900, bold = true }

          -- Brighter text in help documents
          hl.NormalSB = { fg = c.base0, bg = c.base03 }

          -- Change to less distracting color for search highlighting
          hl.Search = { fg = c.green500, reverse = true }

          -- Dark magenta background for visual mode highlighting
          hl.Visual = { bg = c.magenta900, bold = true }

          -- Black background for LSP document highlighting
          hl.LspReferenceText = { bg = c.black }
          hl.LspReferenceRead = { bg = c.black }
          hl.LspReferenceWrite = { bg = c.black }

          -- Filename for modified file in lualine
          hl.ModifiedFile = { fg = c.yellow500, bold = true }

          -- Background color for notifications, used by fade in animation as starting point
          -- hl.NotifyBackground = { bg = "#2E3E46" }
          hl.NotifyBackground = { bg = "#2F505C" }
          -- hl.NotifyBackground = { bg = c.base04 }

          hl.NotifyERRORBody = { fg = c.fg, bg = c.none }
          hl.NotifyWARNBody = { fg = c.fg, bg = c.none }
          hl.NotifyINFOBody = { fg = c.fg, bg = c.none }
          hl.NotifyDEBUGBody = { fg = c.fg, bg = c.none }
          hl.NotifyTRACEBody = { fg = c.fg, bg = c.none }
          hl.NotifyERRORBorder = { fg = darken(c.error, 0.75), bg = c.none }
          hl.NotifyWARNBorder = { fg = darken(c.warning, 0.75), bg = c.none }
          hl.NotifyINFOBorder = { fg = darken(c.info, 0.75), bg = c.none }
          hl.NotifyDEBUGBorder = { fg = darken(c.base01, 0.75), bg = c.none }
          hl.NotifyTRACEBorder = { fg = darken(c.violet500, 0.75), bg = c.none }

          -- Brighter borders and titles for Telescope
          hl.TelescopeBorder = { fg = commentfg, bg = c.base03 }

          -- Override some todo comment styles for better legibility
          hl.TodoBgNOTE = { fg = c.black, bg = c.hint, bold = true }
          hl.TodoBgTODO = { fg = c.black, bg = c.info, bold = true }
          hl.TodoBgPERF = { fg = c.black, bg = c.violet500, bold = true }
          hl.TodoBgTEST = { fg = c.black, bg = c.violet500, bold = true }

          -- Less jarring color for WhichKey item descriptions
          hl.WhichKeyDesc = { fg = c.yellow }

          hl.Testing1 = { fg = c.base1 }
          hl.Testing2 = { fg = c.base0 }
          hl.Testing3 = { fg = commentfg }
          hl.Testing4 = { fg = c.base00 }
          hl.Testing5 = { fg = c.base01 }
          hl.Testing6 = { fg = c.base02 }
        end,
      }
    end,
  },
}

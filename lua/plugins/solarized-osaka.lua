return {
  -- Install & configure solarized-osaka theme
  {
    "craftzdog/solarized-osaka.nvim",
    branch = "main",
    lazy = false,
    priority = 1000,
    opts = function()
      local hsl = require("solarized-osaka.hsl").hslToHex

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
          -- Brighter line numbers with a contrasting current line number and
          -- no cursorline background
          hl.CursorLine = { bg = c.none }
          hl.CursorLineNr = { fg = c.red }
          hl.LineNr = { fg = c.yellow500 }

          -- Dark magenta background for visual mode highlighting
          hl.Visual = { bg = c.magenta900, bold = true }

          -- Brighter text in help documents
          hl.NormalSB = { fg = c.base0, bg = c.base03 }

          -- Brighter comments for better contrast with transparent background
          hl.Comment = { fg = commentfg }

          -- Black background for LSP document highlighting
          hl.LspReferenceText = { bg = c.black }
          hl.LspReferenceRead = { bg = c.black }
          hl.LspReferenceWrite = { bg = c.black }

          -- Brighter borders and titles for Telescope
          hl.TelescopeBorder = { fg = commentfg, bg = c.base03 }

          -- Less jarring color for WhichKey item descriptions
          hl.WhichKeyDesc = { fg = c.yellow }

          hl.Testing1 = { fg = c.base1 }
          hl.Testing2 = { fg = c.base0 }
          hl.Testing3 = { fg = commentfg }
          hl.Testing4 = { fg = c.base00 }
        end,
      }
    end,
  },
}

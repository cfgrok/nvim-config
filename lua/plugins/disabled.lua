return {
  { "bufferline.nvim", enabled = false },
  { "catppuccin", enabled = false },
  { "mini.pairs", enabled = false },
  { "nvim-ts-autotag", enabled = false },
  { "persistence.nvim", enabled = false },

  { "tokyonight.nvim", event = "VeryLazy" },

  -- TODO: investigate column manipulation plugins
  -- { "godlygeek/tabular" }
  -- { "idbrii/textobj-word-column.vim" }

  -- {
  --   "jiangmiao/auto-pairs",
  --   enabled = false,
  --   init = function()
  --     vim.g.AutoPairs = {
  --       ["<%"] = "%>",
  --       ["<%="] = "%>",
  --       ["<%#"] = "%>",
  --       ["("] = ")",
  --       ["["] = "]",
  --       ["{"] = "}",
  --       ["'"] = "'",
  --       ['"'] = '"',
  --       ["`"] = "`",
  --       ["```"] = "```",
  --       ['"""'] = '"""',
  --       ["'''"] = "'''",
  --     }
  --   end,
  -- },
}

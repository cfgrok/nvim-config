return {
  -- Customize flash highlighting
  {
    "flash.nvim",
    opts = {
      highlight = {
        groups = {
          current = "NeogitHunkHeaderHighlight",
          label = "NeogitDiffDeleteHighlight",
          match = "NeogitDiffAddHighlight",
        },
      },
      modes = {
        char = {
          search = { wrap = true },
          label = {
            style = "overlay",
            current = false,
            after = false,
            before = false,
            distance = false,
          },
          highlight = {
            groups = {
              label = "NeogitDiffAddHighlight", -- :hi for f/F
              match = "NeogitDiffAddHighlight", -- :hi for t/T
            },
          },
        },
      },
    },
  },
  {
    "neo-tree.nvim",
    keys = {
      { "<leader>e", false },
      { "<leader>E", false },
    },
  },
  {
    "which-key.nvim",
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        ["<leader>"] = { name = "+leader" },
        ["g"] = { name = "+goto/misc" },
      })
      local wk = require("which-key")
      wk.register({
        mode = { "n", "o", "v" },
        ["<SNR>"] = { "which_key_ignore" },
        ["<c-z>"] = { name = "+emmet" },
        [";"] = { "Jump to next f/F/t/T match" },
        [","] = { "Jump to previous f/F/t/T match" },
      })
      wk.register({
        mode = "n",
        ["<2-LeftMouse>"] = { "which_key_ignore" },
        ["<leader>j"] = { name = "+join/split/misc" },
        ["<a-w>"] = { name = "+window" },
        ["!"] = { name = "+filter through external program" },
        ["<"] = { name = "+indent left" },
        [">"] = { name = "+indent right" },
        ["c"] = { name = "+change" },
        ["d"] = { name = "+delete" },
        ["g~"] = { name = "+toggle case" },
        ["gU"] = { name = "+uppercase" },
        ["v"] = { name = "+visual character mode" },
        ["y"] = { name = "+yank" },
      })
      wk.register({
        mode = "v",
        ["f"] = { name = "Move to next char" },
        ["F"] = { name = "Move to previous char" },
        ["t"] = { name = "Move before next char" },
        ["T"] = { name = "Move before previous char" },
      })
    end,
  },
}

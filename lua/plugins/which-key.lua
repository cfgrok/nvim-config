return {
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

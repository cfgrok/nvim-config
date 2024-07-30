return {
  {
    "andrewradev/splitjoin.vim",
    event = "VeryLazy",
    init = function()
      vim.g.splitjoin_split_mapping = ""
      vim.g.splitjoin_join_mapping = ""
    end,
    keys = {
      { "<leader>jo", "<cmd>SplitjoinJoin<cr>", desc = "Join elements" },
      { "<leader>js", "<cmd>SplitjoinSplit<cr>", desc = "Split elements" },
    },
  },
}

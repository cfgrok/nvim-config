return {
  {
    "leafOfTree/vim-matchtag",
    init = function()
      vim.g.vim_matchtag_enable_by_default = 0
    end,
    keys = {
      { "<leader>uM", "<cmd>MatchTagToggle<cr>", desc = "Toggle HTML Tag Matching" },
    },
  },
}

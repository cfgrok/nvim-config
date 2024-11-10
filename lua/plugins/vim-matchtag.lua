return {
  {
    "leafOfTree/vim-matchtag",
    event = "VeryLazy",
    init = function()
      vim.g.vim_matchtag_enable_by_default = 0

      -- HTML tag match toggle keymapping
      require("snacks")
        .toggle({
          name = "HTML Tag Matching",
          get = function() return vim.g.loaded_matchtag == 1 end,
          set = function() vim.cmd.MatchTagToggle() end,
        })
        :map("<leader>uM")
    end,
  },
}

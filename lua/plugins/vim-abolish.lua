return {
  {
    "tpope/vim-abolish",
    lazy = false,
    init = function()
      LazyVim.on_load("vim-abolish", function()
        vim.keymap.del("n", "cr")
        vim.keymap.set("n", "<leader>cw", "<Plug>(abolish-coerce-word)", { desc = "Coerce word case" })
      end)
    end,
  },
}

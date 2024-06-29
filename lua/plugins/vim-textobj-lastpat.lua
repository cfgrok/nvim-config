return {
  {
    "kana/vim-textobj-lastpat",
    event = "VeryLazy",
    dependencies = { "kana/vim-textobj-user" },
    init = function() vim.g.textobj_lastpat_no_default_key_mappings = 1 end,
    keys = {
      { "a/", "<Plug>(textobj-lastpat-n)", mode = { "x", "o" }, desc = "Last search pattern" },
      { "i/", "<Plug>(textobj-lastpat-n)", mode = { "x", "o" }, desc = "Last search pattern" },
    },
  },
}

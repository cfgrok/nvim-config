return {
  {
    "whatyouhide/vim-textobj-erb",
    event = "VeryLazy",
    dependencies = { "kana/vim-textobj-user" },
    init = function() vim.g.textobj_erb_no_default_key_mappings = 1 end,
    keys = {
      { "aE", "<Plug>(textobj-erb-a)", mode = { "x", "o" }, desc = "ERB tag" },
      { "iE", "<Plug>(textobj-erb-i)", mode = { "x", "o" }, desc = "ERB tag" },
    },
  },
}

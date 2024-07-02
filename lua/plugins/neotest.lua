return {
  {
    "neotest",
    dependencies = {
      "nvim-neotest/neotest-vim-test",
      "vim-test/vim-test",
      "zidhuss/neotest-minitest",
    },
    opts = function(_, opts)
      opts.adapters = {
        -- require("neotest-minitest")({
        --   test_cmd = function()
        --     return vim.iter({ "rake", "test" }):flatten():totable()
        --   end,
        -- }),
        require("neotest-vim-test")({ allow_file_types = { "ruby" } }),
      }
    end,
  },
}

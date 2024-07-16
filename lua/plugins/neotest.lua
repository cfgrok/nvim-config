return {
  {
    "neotest",
    dependencies = {
      "olimorris/neotest-rspec",
      "zidhuss/neotest-minitest",
    },
    opts = function(_, opts)
      opts.adapters = {
        require("neotest-minitest")({}),
        require("neotest-rspec")({}),
      }
    end,
  },
}

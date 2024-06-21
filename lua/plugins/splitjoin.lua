return {
  {
    "andrewradev/splitjoin.vim",
    event = "VeryLazy",
    init = function()
      vim.g.splitjoin_split_mapping = ""
      vim.g.splitjoin_join_mapping = ""
    end,
    keys = {
      { "<leader>jo", "<cmd>SplitjoinJoin<cr>", desc = "join elements" },
      { "<leader>js", "<cmd>SplitjoinSplit<cr>", desc = "split elements" },
    },
  },
  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    opts = {
      ["comment"] = {
        ["source"] = function()
          require("mini.splitjoin").toggle()
        end,
      },
    },
    keys = { { "<leader>jn", "<cmd>NodeAction<cr>", desc = "Trigger node action" } },
  },
  {
    "echasnovski/mini.splitjoin",
    opts = { mappings = { toggle = "<leader>jm" } },
    keys = { { "<leader>jm", desc = "Toggle join/split with mini.splitjoin" } },
  },
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter" },
    opts = {
      max_join_length = 500,
      on_error = function()
        require("mini.splitjoin").toggle()
      end,
      use_default_keymaps = false,
    },
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Split/Join" } },
  },
}

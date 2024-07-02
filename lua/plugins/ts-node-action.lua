return {
  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    opts = {
      ["comment"] = {
        ["source"] = function() require("mini.splitjoin").toggle() end,
      },
    },
    keys = { { "<leader>jn", "<cmd>NodeAction<cr>", desc = "Trigger node action" } },
  },
}

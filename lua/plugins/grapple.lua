return {
  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    opts = {
      quick_select = "hfgls;airtoe",
      scope = "git_branch",
      style = "basename",
    },
    cmd = "Grapple",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<leader>H", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
      { "<leader>h", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
      { "<tab>", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
      { "<s-tab>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
    },
  },
}

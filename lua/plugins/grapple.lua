return {
  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    opts = {
      quick_select = "fsagrewl;h",
      scope = "git_branch",
      style = "basename",
    },
    cmd = "Grapple",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "M", "<cmd>Grapple toggle<cr>", desc = "Grapple Toggle Tag" },
      { "m", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple Toggle Tags Window" },
      { "<tab>", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple Cycle Next Tag" },
      { "<s-tab>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple Cycle Previous Tag" },
    },
  },
}

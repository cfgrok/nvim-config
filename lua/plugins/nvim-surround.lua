return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "gsa",
        normal_cur = "gss",
        normal_line = "gsA",
        normal_cur_line = "gsS",
        visual = "gs",
        visual_line = "gS",
        delete = "gsd",
        change = "gsc",
        change_line = "gsC",
      },
      surrounds = {
        ["="] = {
          add = { "<%= ", " %>" },
          find = function()
            return require("nvim-surround.config").get_selection({
              pattern = "<%%= .- %%>",
            })
          end,
          delete = "^(<%%= )().-( %%>)()$",
        },
        ["-"] = {
          add = { "<% ", " %>" },
          find = function()
            return require("nvim-surround.config").get_selection({
              pattern = "<%% .- %%>",
            })
          end,
          delete = "^(<%% )().-( %%>)()$",
        },
      },
    },
  },
}

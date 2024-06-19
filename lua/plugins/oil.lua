-- Install and configure oil file manager
local detail = false

return {
  {
    "stevearc/oil.nvim",
    opts = {
      use_default_keymaps = false,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-h>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
        ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
        ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
        ["<C-p>"] = "actions.preview",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
        ["q"] = { "actions.close", desc = "Close oil and restore original buffer" },
        ["<C-s>"] = {
          desc = "Save changes",
          callback = function()
            require("oil").save()
          end,
        },
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            detail = not detail
            if detail then
              require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
            else
              require("oil").set_columns({ "icon" })
            end
          end,
        },
      },
    },
    keys = {
      {
        "<leader>fo",
        function()
          require("oil").open_float()
        end,
        desc = "Oil (parent dir)",
      },
      {
        "<leader>fO",
        function()
          require("oil").open_float(LazyVim.root())
        end,
        desc = "Oil (cwd)",
      },
    },
  },
}

return {
  {
    "which-key.nvim",
    opts = function(_, opts)
      opts = vim.tbl_deep_extend("force", opts, {
        preset = "modern",
        delay = function(ctx) return ctx.plugin and 0 or ctx.mode == "o" and 700 or 200 end,
        defer = function(ctx) return vim.list_contains({ "v", "V", "<C-V>" }, ctx.mode) end,
        plugins = {
          presets = {
            windows = false,
          },
        },
        win = { no_overlap = false },
        sort = {
          "order",
          "group",
          -- list "leader" group first ...
          function(item) return (item.key:find("^󱁐 $") and item.group) and 0 or 1 end,
          -- add line(s) below/above/around last ...
          function(item) return item.key:find("󰌑") and 1 or 0 end,
          -- grapple cycle next to last ...
          function(item) return item.key:find("󰌒") and 1 or 0 end,
          -- and Esc just before that
          function(item) return item.key:find("󱊷") and 1 or 0 end,
          -- replicate "alphanum" sort but exclude Ctrl-v and Ctrl-y
          function(item) return (item.key:find("^%w+$") or item.key:find("󰘴 [VY]")) and 0 or 1 end,
          -- special case to list add lines around (Ctrl) after add line above (Shift)
          function(item) return item.key:find("󰘴 󰌑") and 1 or 0 end,
          -- custom key overrides
          function(item)
            local ret = item.key:lower()
            -- list Ctrl-v and Ctrl-y adjacent to v/V and y/Y
            if ret:find("[vy]") then ret = ret:gsub("󰘴 ", "") end
            -- list marks groups together
            if ret:find("`") then ret = "'" end
            return ret
          end,
        },
        icons = { mappings = false },
      })

      vim.list_extend(opts.spec, {
        {
          mode = { "n", "x" },

          -- new/missing/renamed group labels
          { "<leader>", group = "leader" },
          { "<leader>j", group = "join/split/misc" },
          { "<a-w>", group = "windows" },
          { "<c-z>", group = "emmet" },
          { "g", group = "goto/misc" },

          -- proxy <leader>w to Alt-w
          {
            "<leader>w",
            group = "windows",
            proxy = "<a-w>",
            expand = function() return require("which-key.extras").expand.win() end,
          },

          -- add hydra mode mapping
          {
            "<a-w><space>",
            function() require("which-key").show({ keys = "<a-w>", loop = true }) end,
            desc = "Window hydra mode",
          },

          -- hide maximize mapping to prevent Ctrl-w from being detected as a group
          { "<c-w>m", hidden = true },

          -- missing mapping labels
          { "<c-v>", desc = "Visual Block" },
          { "C", desc = "Change to end of line" },
          { "D", desc = "Delete to end of line" },
          { "Y", desc = "Yank to end of line" },
          { "&", desc = "Repeat last substitution" },

          -- restore overridden mapping descriptions
          { "<leader>jm", desc = "Toggle join/split with mini" },
          { "<tab>", desc = "Grapple Cycle Next Tag" },
        },
        {
          mode = "o",

          -- missing group labels
          { "g", group = "misc" },
          { "[", group = "prev node" },
          { "]", group = "next node" },
        },
      })

      return opts
    end,
  },
}

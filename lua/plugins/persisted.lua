return {
  {
    "olimorris/persisted.nvim",
    lazy = false,
    priority = 900,
    opts = function(_, opts)
      LazyVim.on_load("telescope.nvim", function() require("telescope").load_extension("persisted") end)

      local group = vim.api.nvim_create_augroup("PersistedHooks", { clear = true })
      vim.api.nvim_create_autocmd({ "User" }, {
        group = group,
        pattern = "PersistedTelescopeLoadPre",
        callback = function()
          -- Save the currently loaded session using a global variable
          require("persisted").save({ session = vim.g.persisted_loaded_session })

          -- Delete all of the open buffers
          vim.cmd("%bd!")
        end,
      })
      -- TODO: investigate autocmd error
      -- vim.api.nvim_create_autocmd("User", {
      --   group = group,
      --   pattern = "PersistedLoadPost",
      --   callback = function(session) vim.fn.execute("!git checkout " .. session.data.branch) end,
      -- })

      opts = {
        use_git_branch = true,
        autoload = true,
        -- on_autoload_no_session = function() vim.notify("No existing session to load.") end,
        follow_cwd = false,
        allowed_dirs = {
          "~/.config/nvim",
          "~/Documents/workspace",
        },
      }
      return opts
    end,
    keys = {
      { "<leader>qd", "<cmd>SessionStop<cr>", desc = "Don't Save Current Session" },
      { "<leader>qs", "<cmd>Telescope persisted<cr>", desc = "Switch Session" },
    },
  },
}

return {
  {
    "nvim-cmp",
    -- Keymap to toggle autocompletion
    keys = {
      {
        "<leader>ua",
        function()
          local cmp = require("cmp")

          vim.g.cmp_autocomplete = vim.g.cmp_autocomplete ~= nil and not vim.g.cmp_autocomplete
          if vim.g.cmp_autocomplete then
            cmp.setup({ completion = { autocomplete = { "TextChanged" } } })
            LazyVim.info("Autocomplete enabled", { title = "Autocompletion" })
          else
            cmp.setup({ completion = { autocomplete = false } })
            LazyVim.warn("Autocomplete disabled", { title = "Autocompletion" })
          end
        end,
        desc = "Toggle Autocompletion",
      },
    },
    -- Configure "supertab" for completion and snippet navigation, as well as
    -- Ctrl-space for toggling completion menu and escape for closing it
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function() vim.snippet.jump(1) end)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function() vim.snippet.jump(-1) end)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-Space>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort()
          else
            cmp.complete()
          end
        end, { "i", "s" }),
        ["<Esc>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort()
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
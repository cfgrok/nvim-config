return {
  {
    "nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Autocompletion toggle keymapping
      vim.g.cmp_autocomplete = true
      LazyVim.toggle.map("<leader>ua", {
        name = "Autocompletion",
        get = function() return vim.g.cmp_autocomplete end,
        set = function(state)
          vim.g.cmp_autocomplete = state
          if state then
            cmp.setup({ completion = { autocomplete = { "TextChanged" } } })
          else
            cmp.setup({ completion = { autocomplete = false } })
          end
        end,
      })

      -- Configure "supertab" for completion and snippet navigation, as well as
      -- Ctrl-space for toggling completion menu and escape for closing it
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

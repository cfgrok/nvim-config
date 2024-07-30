return {
  {
    "abecodes/tabout.nvim",
    event = "VeryLazy",
    init = function()
      -- Disable tabout for filetypes without a treesitter parser
      LazyVim.on_load("nvim-treesitter", function()
        vim.api.nvim_create_autocmd("BufEnter", {
          group = vim.api.nvim_create_augroup("tabout_disable", { clear = true }),
          callback = function()
            if Is_normal_buffer() then
              local has_parser = require("nvim-treesitter.parsers").has_parser()
              local tabout = require("tabout")
              local enabled = tabout.is_enabled()
              if (enabled and not has_parser) or (not enabled and has_parser) then tabout.toggle() end
            end
          end,
        })
      end)

      -- require("tabout.config").debug = true
    end,
    opts = {
      act_as_shift_tab = true,
      ignore_beginning = true,
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
        { open = "<", close = ">" },
        { open = "|", close = "|" },
      },
    },
    dependencies = {
      "hrsh7th/nvim-cmp",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<c-tab>", "<Plug>(TaboutMulti)", mode = "i", desc = "Tab out from pairs" },
      { "<c-s-tab>", "<Plug>(TaboutBackMulti)", mode = "i", desc = "Tab backwards out from pairs" },
    },
  },
}

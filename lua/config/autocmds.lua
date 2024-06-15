-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Start in insert mode for git commits
vim.api.nvim_create_augroup("Git", {})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "COMMIT_EDITMSG",
  callback = function()
    vim.wo.spell = true
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    if vim.fn.getline(1) == "" then
      vim.cmd("startinsert!")
    end
  end,
  group = "Git",
})

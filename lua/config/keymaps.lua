-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local ks = vim.keymap.set

-- Closure for adding blank lines above/below current line and returning to the starting position
local newline = function(above)
  local inner = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local cmd = "put"
    if above then
      cmd = cmd .. "!"
      line = line + 1
    end
    vim.api.nvim_command(cmd .. "=nr2char(10)")
    vim.api.nvim_win_set_cursor(0, { line, col })
  end

  return function()
    inner()
  end
end

-- Add blank line above/below
ks("n", "<s-cr>", newline(true), { desc = "Add blank line above" })
ks("n", "<cr>", newline(), { desc = "Add blank line below" })

-- Open new line above/below without continuing comment
ks("n", "<leader>O", "O<esc>^Da", { desc = "Start new non-comment line above" })
ks("n", "<leader>o", "o<esc>^Da", { desc = "Start new non-comment line below" })

-- Set jump to line start mark key to jump to position with which-key command
ks("n", "'", "<cmd>lua require('which-key').show('`', {mode = 'n', auto = true})<cr>")

-- Close all other windows
ks("n", "<leader>wo", "<c-w>o", { desc = "Close all other windows" })

-- Jump to start/end of line
ks("n", "<m-h>", "^", { desc = "Start of line" })
ks("n", "<m-l>", "$", { desc = "End of line" })

-- Quit all with CTRL-q
ks("n", "<c-q>", "<cmd>qa<cr>", { desc = "Quit all" })

-- Overload ESC and CTRL-e to turn off search highlights and dismiss all popups/floats
ks({ "n", "i" }, "<esc>", "<cmd>noh<cr><cmd>NoiceDismiss<cr><esc>", { desc = "Disable highlights/popups" })
ks({ "n", "i" }, "<c-e>", "<cmd>noh<cr><cmd>NoiceDismiss<cr>", { desc = "Disable highlights/popups" })

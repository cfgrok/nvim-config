-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Function to clear everything and redraw
local function clear_and_redraw()
  if vim.snippet.active() then vim.snippet.stop() end
  vim.cmd.NoiceDismiss()
  vim.cmd.nohlsearch()
  vim.cmd.diffupdate()
  vim.cmd("normal! <c-l>")
end

-- Function to expand directory path of current file
local function expand_cwd()
  if vim.fn.getcmdtype() == ":" then
    return vim.fn.expand("%:h") .. "/"
  else
    return "%%"
  end
end

local function qf_wrap()
  vim.g.qf_open = true
  vim.cmd.copen()
end

-- Expand current working directory in command line
map("c", "%%", expand_cwd, { desc = "Expand cwd", expr = true })

-- Add comma/semicolon to end of line in insert mode
map("i", ",,", "<esc><cmd>keepjumps norm A,<cr><esc>gi", { desc = "Add comma to EOL" })
map("i", ";;", "<esc><cmd>keepjumps norm A;<cr><esc>gi", { desc = "Add semicolon to EOL" })

-- Open new line above/below without continuing comment
map("n", "O", 'O<esc>"_cc', { desc = "Start New Non-Comment Line Above" })
map("n", "o", 'o<esc>"_cc', { desc = "Start New Non-Comment Line Below" })

-- Set jump to line start mark key to jump to position with which-key command
map("n", "'", "<cmd>lua require('which-key').show('`', {mode = 'n', auto = true})<cr>")

-- Remap jump to line start mark key to jump to position in visual and operator-pending modes
map({ "x", "o" }, "'", "`", { desc = "To Mark Position" })

-- Jump to start/end of line
map({ "n", "x", "o" }, "<s-h>", "^", { desc = "Start of Line" })
map({ "n", "x", "o" }, "<s-l>", "$", { desc = "End of Line" })

-- Go to previous/next buffer
map("n", "<a-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<a-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Delete all other buffers
map("n", "<leader>bo", "<cmd>%bd!<bar>e#<bar>bd#<cr>", { desc = "Delete Other Buffers" })

-- Add mapping for LazyExtras
map("n", "<leader>cx", "<cmd>LazyExtras<cr>", { desc = "Lazy Extras" })

-- Surround shortcuts
map("n", "<leader>j(", "gsaiW(", { desc = "Surround WORD With (", remap = true })
map("n", "<leader>j)", "gsaiW)", { desc = "Surround WORD With )", remap = true })
map("n", "<leader>j{", "gsaiW{", { desc = "Surround WORD With {", remap = true })
map("n", "<leader>j}", "gsaiW}", { desc = "Surround WORD With }", remap = true })
map("n", "<leader>j[", "gsaiW[", { desc = "Surround WORD With [", remap = true })
map("n", "<leader>j]", "gsaiW]", { desc = "Surround WORD With ]", remap = true })
map("n", '<leader>j"', 'gsaiW"', { desc = 'Surround WORD With "', remap = true })
map("n", "<leader>j'", "gsaiW'", { desc = "Surround WORD With '", remap = true })

-- Substitution/global shortcuts
map("n", "<leader>jg", ":g/\\<", { desc = "Start global word matching command" })
map("n", "<leader>jv", ":v/\\<", { desc = "Start global NOT word matching command" })
map("n", "<leader>jp", ":'{,'}s/\\<<c-r><c-w>\\>//g<left><left>", { desc = "Replace in paragraph" })
map("n", "<leader>jr", ":%s/\\<<c-r><c-w>\\>//g<left><left>", { desc = "Replace in buffer" })
map("x", "<leader>sr", ":s/\\<<c-r><c-w>\\>//g<left><left>", { desc = "Replace in selection" })

-- Remap m/M under leader
map("n", "<leader>m", "m", { desc = "Set Mark" })
map("n", "<leader>M", "M", { desc = "Move to Screen Middle" })

-- Toggle floating IRB terminal
map(
  "n",
  "<leader>qi",
  function() LazyVim.terminal({ "irb" }, { cwd = LazyVim.root() }) end,
  { desc = "IRB Terminal (Root dir)" }
)
map("n", "<leader>qI", function() LazyVim.terminal({ "irb" }) end, { desc = "IRB Terminal (cwd)" })

-- Customize line number toggle mappings
map("n", "<leader>ul", function() LazyVim.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
vim.keymap.del("n", "<leader>uL")

-- Clear notifications/snippets/hlsearch, diffupdate and redraw
map("n", "<leader>uR", clear_and_redraw, { desc = "Clear and Redraw" })

map("n", "<leader>xq", qf_wrap, { desc = "Quickfix List" })

-- Additional window mappings
map("n", "<leader>wa", "<c-w>_", { desc = "Max Height" })
map("n", "<leader>we", "<c-w>=", { desc = "Equal Size" })
map("n", "<leader>wo", "<c-w>o", { desc = "Delete Other Windows" })
map("n", "<leader>ws", "<c-w>s", { desc = "Split Window Below" })
map("n", "<leader>wv", "<c-w>v", { desc = "Split Window Right" })
map("n", "<leader>wx", "<c-w>x", { desc = "Swap With Next" })
map("n", "<leader>wh", "<c-w>h", { desc = "Go to the left window" })
map("n", "<leader>wj", "<c-w>j", { desc = "Go to the down window" })
map("n", "<leader>wk", "<c-w>k", { desc = "Go to the up window" })
map("n", "<leader>wl", "<c-w>l", { desc = "Go to the right window" })
map("n", "<leader>wH", "<c-w>H", { desc = "Move window left" })
map("n", "<leader>wJ", "<c-w>J", { desc = "Move window down" })
map("n", "<leader>wK", "<c-w>K", { desc = "Move window up" })
map("n", "<leader>wL", "<c-w>L", { desc = "Move window right" })

-- Map Alt-w for commonly-used window commands (mirrors which-key defaults for <c-w>)
map("n", "<a-w>s", "<c-w>s", { desc = "Split window" })
map("n", "<a-w>v", "<c-w>v", { desc = "Split window vertically" })
map("n", "<a-w>w", "<c-w>w", { desc = "Switch windows" })
map("n", "<a-w>q", "<c-w>q", { desc = "Quit a window" })
map("n", "<a-w>o", "<c-w>o", { desc = "Close all other windows" })
map("n", "<a-w>T", "<c-w>T", { desc = "Break out into a new tab" })
map("n", "<a-w>x", "<c-w>x", { desc = "Swap current with next" })
map("n", "<a-w>-", "<c-w>-", { desc = "Decrease height" })
map("n", "<a-w>+", "<c-w>+", { desc = "Increase height" })
map("n", "<a-w><lt>", "<c-w><lt>", { desc = "Decrease width" })
map("n", "<a-w>>", "<c-w>>", { desc = "Increase width" })
map("n", "<a-w>|", "<c-w>|", { desc = "Max out the width" })
map("n", "<a-w>_", "<c-w>_", { desc = "Max out the height" })
map("n", "<a-w>a", "<c-w>_", { desc = "Max out the height" })
map("n", "<a-w>=", "<c-w>=", { desc = "Equally high and wide" })
map("n", "<a-w>e", "<c-w>=", { desc = "Equally high and wide" })
map("n", "<a-w>h", "<c-w>h", { desc = "Go to the left window" })
map("n", "<a-w>j", "<c-w>j", { desc = "Go to the down window" })
map("n", "<a-w>k", "<c-w>k", { desc = "Go to the up window" })
map("n", "<a-w>l", "<c-w>l", { desc = "Go to the right window" })
map("n", "<a-w>H", "<c-w>H", { desc = "Move window left" })
map("n", "<a-w>J", "<c-w>J", { desc = "Move window down" })
map("n", "<a-w>K", "<c-w>K", { desc = "Move window up" })
map("n", "<a-w>L", "<c-w>L", { desc = "Move window right" })

map("i", "<a-h>", "<c-o><c-w>h", { desc = "Go to the left window" })
map("i", "<a-j>", "<c-o><c-w>j", { desc = "Go to the down window" })
map("i", "<a-k>", "<c-o><c-w>k", { desc = "Go to the up window" })
map("i", "<a-l>", "<c-o><c-w>l", { desc = "Go to the right window" })

-- Map CTRL-i to itself to prevent subsequent tab mapping from clobbering it
map("n", "<c-i>", "<c-i>")

-- Yank buffer contents into clipboard
map("n", "<c-y>", ":%y<cr>", { desc = "Yank Buffer to Clipboard" })

-- Save with CTRL-s
map({ "n", "i", "x", "s" }, "<c-s>", "<cmd>w<cr>", { desc = "Save File" })

-- Quit all with CTRL-q
map({ "n", "i", "v" }, "<c-q>", "<cmd>qa<cr>", { desc = "Quit All" })

-- Overload ESC and CTRL-e to turn off search highlights and dismiss all popups/floats in insert mode
map({ "n", "i" }, "<esc>", "<cmd>noh<cr><cmd>NoiceDismiss<cr><esc>", { desc = "Disable Highlights/Popups" })
map({ "n", "i" }, "<c-e>", "<cmd>noh<cr><cmd>NoiceDismiss<cr>", { desc = "Disable Highlights/Popups" })

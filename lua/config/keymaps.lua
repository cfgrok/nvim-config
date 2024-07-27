-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del = vim.keymap.del

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
map("x", "<leader>ss", ":s/\\<<c-r><c-w>\\>//g<left><left>", { desc = "Replace in selection" })

-- Remap m/M under leader
map("n", "<leader>m", "m", { desc = "Set Mark" })
map("n", "<leader>M", "M", { desc = "Middle Line of Window" })

-- TODO: investigate moving to gitsigns plugin config
-- Duplicate gitsigns mappings with 'target = "all"' option to support staged hunks
local gs = require("gitsigns")
map("n", "]g", function()
  if vim.wo.diff then
    vim.cmd.normal({ "]c", bang = true })
  else
    gs.nav_hunk("next", { target = "all" })
  end
end, { desc = "Next Hunk" })
map("n", "[g", function()
  if vim.wo.diff then
    vim.cmd.normal({ "[c", bang = true })
  else
    gs.nav_hunk("prev", { target = "all" })
  end
end, { desc = "Prev Hunk" })
map("n", "]G", function() gs.nav_hunk("last", { target = "all" }) end, { desc = "Last Hunk" })
map("n", "[G", function() gs.nav_hunk("first", { target = "all" }) end, { desc = "First Hunk" })

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

-- Open Quickfix list with wrapper function to disable buffer-local mappings
map("n", "<leader>xq", qf_wrap, { desc = "Quickfix List" })

-- Remove custom Ctrl-w mappings
del("n", "<c-w><space>")
del("n", "<c-w><c-d>")
del("n", "<c-w>d")

-- Add maximize window mapping
LazyVim.toggle.map("<a-w>m", LazyVim.toggle.maximize)

-- Map Alt-w for commonly-used window commands
map("n", "<a-w>a", "<c-w>_", { desc = "Max height" })
map("n", "<a-w>d", "<c-w>c", { desc = "Delete window" })
map("n", "<a-w>e", "<c-w>=", { desc = "Equal size" })
map("n", "<a-w>h", "<c-w>h", { desc = "Go to the left window" })
map("n", "<a-w>H", "<c-w>H", { desc = "Move window left" })
map("n", "<a-w>j", "<c-w>j", { desc = "Go to the lower window" })
map("n", "<a-w>J", "<c-w>J", { desc = "Move window down" })
map("n", "<a-w>k", "<c-w>k", { desc = "Go to the upper window" })
map("n", "<a-w>K", "<c-w>K", { desc = "Move window up" })
map("n", "<a-w>l", "<c-w>l", { desc = "Go to the right window" })
map("n", "<a-w>L", "<c-w>L", { desc = "Move window right" })
map("n", "<a-w>o", "<c-w>o", { desc = "Delete other windows" })
map("n", "<a-w>q", "<c-w>q", { desc = "Quit a window" })
map("n", "<a-w>s", "<c-w>s", { desc = "Split window below" })
map("n", "<a-w>v", "<c-w>v", { desc = "Split window right" })
map("n", "<a-w>T", "<c-w>T", { desc = "Break out into a new tab" })
map("n", "<a-w>w", "<c-w>w", { desc = "Switch windows" })
map("n", "<a-w>x", "<c-w>x", { desc = "Swap with next" })
map("n", "<a-w>+", "<c-w>+", { desc = "Increase height" })
map("n", "<a-w>-", "<c-w>-", { desc = "Decrease height" })
map("n", "<a-w><lt>", "<c-w><lt>", { desc = "Decrease width" })
map("n", "<a-w>=", "<c-w>=", { desc = "Equal size" })
map("n", "<a-w>>", "<c-w>>", { desc = "Increase width" })
map("n", "<a-w>_", "<c-w>_", { desc = "Max height" })
map("n", "<a-w>|", "<c-w>|", { desc = "Max width" })

-- Window navigation in insert mode
map("i", "<a-h>", "<c-o><c-w>h", { desc = "Go to the left window" })
map("i", "<a-j>", "<c-o><c-w>j", { desc = "Go to the down window" })
map("i", "<a-k>", "<c-o><c-w>k", { desc = "Go to the up window" })
map("i", "<a-l>", "<c-o><c-w>l", { desc = "Go to the right window" })

-- Map CTRL-i to itself to prevent subsequent tab mapping from clobbering it
map("n", "<c-i>", "<c-i>")

-- Yank buffer contents into clipboard
map("n", "<c-y>", ":%y<cr>", { desc = "Yank buffer to clipboard" })

-- Save with CTRL-s in visual/select mode without escape
map({ "x", "s" }, "<c-s>", "<cmd>w<cr>", { desc = "Save File" })

-- Close with CTRL-w -- fallback for buffer keymap
map({ "n", "x", "s" }, "<c-w>", LazyVim.ui.bufremove, { desc = "Delete Buffer" })

-- Quit all with CTRL-q
map({ "n", "i", "v" }, "<c-q>", "<cmd>qa<cr>", { desc = "Quit All" })

-- Overload ESC and CTRL-e to turn off search highlights and dismiss all popups/floats in insert mode
map({ "n", "i" }, "<esc>", "<cmd>noh<cr><cmd>NoiceDismiss<cr><esc>", { desc = "Disable Highlights/Popups" })
map({ "n", "i" }, "<c-e>", "<cmd>noh<cr><cmd>NoiceDismiss<cr>", { desc = "Disable Highlights/Popups" })

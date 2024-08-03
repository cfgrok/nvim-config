-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Function used to detect a "normal" buffer -- defined as a global function
-- due to use in autocmds defined within plugin specs -- detection does not
-- work reliably when opening the quickfix list, so the vim.g.qf_open variable
-- is set to true in a wrapper function on the keymap as a workaround
function Is_normal_buffer(win)
  local winid = win or vim.api.nvim_get_current_win()

  -- Using pcall as a guard condition to exit gracefully on exceptions
  local status, bufid = pcall(vim.api.nvim_win_get_buf, winid)
  if not status then return false end

  local normal_buffer = vim.api.nvim_get_option_value("buftype", { buf = bufid }) == ""
  local modifiable = vim.api.nvim_get_option_value("modifiable", { buf = bufid })
  local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
  local qf_open = vim.g.qf_open
  vim.g.qf_open = false

  return normal_buffer and modifiable and not floating and not qf_open
end

-- Mapping <cr> is problematic for certain buffer types, so using buffer-local
-- mappings with a check for a "normal" buffer to prevent issues
local function load_buffer_keymaps()
  vim.schedule(function()
    if Is_normal_buffer() then
      -- Add blank line(s) below/above/around
      vim.keymap.set(
        "n",
        "<c-cr>",
        "<cmd>call append(line('.')-1, '')<cr><cmd>call append('.', '')<cr>",
        { desc = "Add Blank Lines Around", buffer = true }
      )
      vim.keymap.set(
        "n",
        "<s-cr>",
        "<cmd>call append(line('.')-1, '')<cr>",
        { desc = "Add Blank Line Above", buffer = true }
      )
      vim.keymap.set("n", "<cr>", "<cmd>call append('.', '')<cr>", { desc = "Add Blank Line Below", buffer = true })

      -- Override CTRL-w to delete buffer, using nowait to prevent timeoutlen delay
      vim.keymap.set(
        { "n", "x", "s" },
        "<c-w>",
        LazyVim.ui.bufremove,
        { desc = "Delete Buffer", nowait = true, buffer = true }
      )
    end
  end)
end

local ac = vim.api.nvim_create_autocmd
local function ag(name) return vim.api.nvim_create_augroup(name, { clear = true }) end

-- Start in insert mode for git commits
ac("FileType", {
  group = ag("gitcommit"),
  pattern = "gitcommit",
  callback = function()
    vim.wo.spell = true
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    if vim.fn.getline(1) == "" then vim.cmd("startinsert!") end
  end,
})

-- Add trailing comma when starting new line in JSON files
ac("FileType", {
  group = ag("json_comma"),
  pattern = "json",
  callback = function()
    vim.keymap.set("n", "o", function()
      local line = vim.api.nvim_get_current_line()
      local should_add_comma = line:match("[^,{[]$")
      if should_add_comma then
        return "A,<cr>"
      else
        return "o"
      end
    end, { buffer = true, expr = true })
  end,
})

-- Disable format on save for specified filetypes
local disabled_filetypes = { "cf" }
for _, ft in pairs(disabled_filetypes) do
  ac("FileType", {
    group = ag("formatting_disabled_filetypes_" .. ft),
    pattern = ft,
    callback = function() vim.b.autoformat = false end,
  })
end

-- Delete vim-rails window keymaps
ac("FileType", {
  group = ag("rails_keymaps"),
  pattern = "ruby",
  callback = function()
    pcall(vim.keymap.del, "n", "<c-w>f", { buffer = true })
    pcall(vim.keymap.del, "n", "<c-w>gf", { buffer = true })
    pcall(vim.keymap.del, "n", "<c-w><c-f>", { buffer = true })
  end,
})

-- Override vim-rails setting YAML file to eruby.yaml filetype
ac("FileType", {
  group = ag("eruby_yaml"),
  pattern = "eruby.yaml",
  command = "set filetype=yaml",
})

-- Automatically create buffer mappings for non-excluded buffer/filetypes
ac({ "BufAdd", "BufRead" }, {
  group = ag("buffer_mappings"),
  callback = load_buffer_keymaps,
})

-- When autoloading a session the first buffer is loaded before autocmds and
-- LSP initialization, so this autocmd is used to reload the initial buffer
-- after LSP loading completes so the buffer_mappings autocmd will execute and
-- LSP attachment can occur -- triggered by the LazyVim event which is fired
-- after autocmd loading
ac("User", {
  group = ag("reload_after_lsp_load"),
  pattern = "LazyVimAutocmds",
  callback = function()
    if Is_normal_buffer() then
      LazyVim.on_load("nvim-lspconfig", function()
        vim.schedule(function() vim.cmd.edit() end)
      end)
    end
  end,
})

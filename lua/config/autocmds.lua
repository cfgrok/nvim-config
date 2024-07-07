-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.g.qf_open = false
local function is_normal_buffer(win)
  local winid = win or vim.api.nvim_get_current_win()
  local bufid = vim.api.nvim_win_get_buf(winid)
  local normal_buffer = vim.api.nvim_get_option_value("buftype", { buf = bufid }) == ""
  local modifiable = vim.api.nvim_get_option_value("modifiable", { buf = bufid })
  local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
  local qf_open = vim.g.qf_open
  vim.g.qf_open = false
  return normal_buffer and modifiable and not floating and not qf_open
end

local function load_buffer_keymaps()
  vim.schedule(function()
    if is_normal_buffer() then
      -- Add blank line above/below
      vim.keymap.set(
        "n",
        "<c-cr>",
        "<cmd>call append(line('.')-1, '')<cr><cmd>call append('.', '')<cr>",
        { desc = "Add Blank Line Above and Below", buffer = true }
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
    group = ag("formatting_disabled_filetypes"),
    pattern = ft,
    callback = function() vim.b.autoformat = false end,
  })
end

-- Disable tabout for filetypes without a treesitter parser
ac("BufEnter", {
  group = ag("tabout_disable"),
  callback = function()
    if is_normal_buffer() then
      local has_parser = require("nvim-treesitter.parsers").has_parser()
      local tabout = require("tabout")
      local enabled = tabout.is_enabled()

      if (enabled and not has_parser) or (not enabled and has_parser) then tabout.toggle() end
    end
  end,
})

-- Automatically create buffer mappings for non-excluded buffer/filetypes
ac({ "BufAdd", "BufRead" }, {
  group = ag("buffer_mappings"),
  callback = load_buffer_keymaps,
})

-- Autocmds are not loaded yet when session autoloads, so a separate autocmd is
-- required to attach buffer keymaps to the first buffer -- triggered by the
-- LazyVim event which is fired on autocmd loading
ac("User", {
  group = ag("buffer_mappings_on_load"),
  pattern = "LazyVimAutocmds",
  callback = load_buffer_keymaps,
})

-- Add line numbers to telescope previews
ac("User", {
  group = ag("telescope_previewer"),
  pattern = "TelescopePreviewerLoaded",
  callback = function(args)
    if args.data.filetype ~= "help" then vim.wo.number = true end
  end,
})

vim.g.last_active_window = 1000
ac("WinEnter", {
  group = ag("toggle_tint"),
  callback = function()
    local tint = require("tint")
    local win = vim.api.nvim_get_current_win()
    local qf_open = vim.g.qf_open
    vim.schedule(function()
      if not qf_open and is_normal_buffer(win) then vim.g.last_active_window = win end
      local wins = vim.api.nvim_list_wins()
      for _, w in pairs(wins) do
        if w ~= win and is_normal_buffer(w) then tint.tint(w) end
      end
      tint.untint(vim.g.last_active_window)
    end)
  end,
})

ac({ "BufNewFile", "BufRead" }, {
  group = ag("ansible_yaml"),
  pattern = "*/provision/*.yml",
  callback = function() vim.bo.filetype = "yaml.ansible" end,
})

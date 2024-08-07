-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local vg = vim.g
local vo = vim.o

vg.lazygit_config = false
-- WARNING: investigate issue with prettier -- conform healthcheck reports:
-- WARNING prettier unavailable: Condition failed
vg.lazyvim_prettier_needs_config = false
vg.no_ruby_maps = true
vg.ruby_host_prog = "~/.local/rbenv/versions/3.3.4/bin/neovim-ruby-host"
vg.loaded_perl_provider = 0

vo.cedit = "<c-o>"
vo.mouse = ""
vo.scrolloff = 2
vo.signcolumn = "yes:2"

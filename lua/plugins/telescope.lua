local actions = require("telescope.actions")

local function multiopen(prompt_bufnr)
  local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()

  if vim.tbl_isempty(multi) then
    actions.select_default(prompt_bufnr)
    return
  end

  actions.close(prompt_bufnr)
  for _, entry in pairs(multi) do
    local filename = entry.filename or entry.value
    local lnum = entry.lnum or 1
    local lcol = entry.col or 1
    if filename then
      vim.cmd(string.format("edit +%d %s", lnum, filename))
      vim.cmd(string.format("normal! %dG%d|", lnum, lcol))
    end
  end
end

return {
  -- Customize telescope layout and sorting
  {
    "telescope.nvim",
    opts = function(_, opts)
      local defaults = {
        layout_config = {
          horizontal = {
            preview_width = 0.6,
            prompt_position = "top",
            width = 0.9,
          },
        },
        mappings = {
          i = {
            ["<c-f>"] = actions.preview_scrolling_left,
            ["<cr>"] = multiopen,
          },
          n = {
            ["<cr>"] = multiopen,
          },
        },
        sorting_strategy = "ascending",
      }
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, defaults)
      return opts
    end,
    keys = {
      { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
      { "<leader>fR", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    },
  },
}

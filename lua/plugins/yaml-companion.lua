local function get_schema()
  local schema = require("yaml-companion").get_buf_schema(0)
  if schema.result[1].name == "none" then return end
  LazyVim.info(schema.result[1].name, { title = "YAML Schema" })
end

return {
  "someone-stole-my-name/yaml-companion.nvim",
  event = "VeryLazy",
  config = function()
    local cfg = require("yaml-companion").setup({
      lspconfig = {
        filetypes = { "yaml", "yaml.ansible" },
      },
    })
    require("lspconfig")["yamlls"].setup(cfg)
    LazyVim.on_load("telescope.nvim", function() require("telescope").load_extension("yaml_schema") end)
  end,
  keys = {
    { "<leader>ty", "<cmd>Telescope yaml_schema<cr>", desc = "Select YAML schema" },
    { "<leader>tz", get_schema, desc = "Show current YAML schema" },
  },
}

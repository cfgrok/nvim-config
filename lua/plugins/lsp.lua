-- Solargraph LSP server helper function -- executes via Bundler if the
-- solargraph gem is included in the Gemfile, otherwise uses the system gem
local solargraph_cmd = function()
  local ret_code = nil
  local jid = vim.fn.jobstart("bundle info solargraph", {
    on_exit = function(_, data)
      ret_code = data
    end,
  })
  vim.fn.jobwait({ jid }, 5000)
  if ret_code == 0 then
    return { "bundle", "exec", "solargraph", "stdio" }
  end
  return { "solargraph", "stdio" }
end

return {
  -- Add/configure solargraph LSP server
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        html = {
          filetypes = { "eruby", "html", "templ" },
          init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
              css = true,
              javascript = true,
            },
            provideFormatter = true,
          },
        },
        solargraph = {
          cmd = solargraph_cmd(),
          root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git", "."),
          settings = {
            solargraph = {
              autoformat = true,
              completion = true,
              definitions = true,
              diagnostics = true,
              folding = true,
              formatting = true,
              highlights = true,
              references = true,
              rename = true,
              symbols = true,
            },
          },
        },
      },
    },
  },
}

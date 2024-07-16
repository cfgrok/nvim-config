-- Solargraph LSP server helper function -- executes via Bundler if the
-- solargraph gem is included in the Gemfile, otherwise uses the system gem
local solargraph_cmd = function()
  local ret_code = nil
  local jid = vim.fn.jobstart("bundle info solargraph", {
    on_exit = function(_, data) ret_code = data end,
  })
  vim.fn.jobwait({ jid }, 5000)
  if ret_code == 0 then return { "bundle", "exec", "solargraph", "stdio" } end
  return { "solargraph", "stdio" }
end

return {
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        emmet_ls = { filetypes = { "cf" } },
        html = {
          filetypes = { "cf", "eruby", "html", "templ" },
          init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
              css = true,
              javascript = true,
            },
            provideFormatter = true,
          },
        },
        ruby_lsp = {
          autostart = false,
          cmd = { "bundle", "exec", "ruby-lsp" },
          init_options = {
            enabledFeatures = {
              "codeActions",
              "completion",
              "diagnostics",
              "documentHighlights",
              "documentLink",
              "documentSymbols",
              "foldingRanges",
              "formatting",
              "hover",
              "inlayHint",
              "onTypeFormatting",
              "selectionRanges",
              "semanticHighlighting",
            },
            formatter = "standard",
            linters = { "standard" },
          },
          settings = {},
        },
        -- Add/configure solargraph LSP server
        solargraph = {
          cmd = solargraph_cmd(),
          root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git", "."),
          settings = {
            solargraph = {
              autoformat = false,
              completion = true,
              definitions = true,
              diagnostics = true,
              folding = true,
              formatting = false,
              highlights = true,
              references = true,
              rename = true,
              symbols = true,
            },
          },
        },
        tailwindcss = {
          settings = {
            tailwindCSS = {
              classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
              includeLanguages = { eruby = "erb" },
              lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
              },
              validate = true,
            },
          },
        },
      },
    },
  },
}

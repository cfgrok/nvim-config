-- Bundler LSP server helper function -- executes via bundler if the command's
-- gem is included in the Gemfile, otherwise uses the system gem
local bundle_cmd = function(cmd)
  local ret_code = nil
  local jid = vim.fn.jobstart("cat Gemfile | rg " .. cmd[1], {
    on_exit = function(_, data) ret_code = data end,
  })
  vim.fn.jobwait({ jid }, 1000)
  if ret_code == 0 then return vim.list_extend({ "bundle", "exec" }, cmd) end
  return cmd
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
        rubocop = {
          enabled = false,
          cmd = bundle_cmd({ "rubocop", "--lsp" }),
        },
        ruby_lsp = {
          enabled = false,
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
        solargraph = {
          cmd = bundle_cmd({ "solargraph", "stdio" }),
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
        standardrb = {
          enabled = false,
          cmd = bundle_cmd({ "standardrb", "--lsp" }),
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

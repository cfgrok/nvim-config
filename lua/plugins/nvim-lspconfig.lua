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
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
            },
          },
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = false,
        },
        -- Enable lsp cursor word highlighting
        document_highlight = {
          enabled = true,
        },
        -- add any global capabilities here
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        ---@type lspconfig.options
        servers = {
          lua_ls = {
            -- mason = false, -- set to false if you don't want this server to be installed with mason
            -- Use this to add any additional keymaps
            -- for specific lsp servers
            -- ---@type LazyKeysSpec[]
            -- keys = {},
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
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
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
      return ret
    end,
  },
}

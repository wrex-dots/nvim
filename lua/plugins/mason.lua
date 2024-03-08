local fox = require("foxutils")
local FormatOnSave = vim.api.nvim_create_augroup("FormatOnSave", {})
local FixOnSave = vim.api.nvim_create_augroup("FixOnSave", {})
---@type LazySpec[]
local extra_deps = {}

table.insert(extra_deps, { -- TreeSitter powered range selection
  "mfussenegger/nvim-treehopper",

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },

  event = "Syntax *",

  config = function()
    local desc = "TS Hopper: Select node"
    local tsht = require "tsht"

    fox.keys.noremap.n(desc, "<Space>", tsht.nodes)
  end,
})

table.insert(extra_deps, { -- Automatic ctags generation
  "JMarkin/gentags.lua",

  cond = fox.systemhas "ctags",

  dependencies = { "nvim-lua/plenary.nvim" },

  config = true,
})

table.insert(extra_deps, { -- VSCode-like inlay hints
  "lvimuser/lsp-inlayhints.nvim",

  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("LspAttachInlayHints", {}),
      callback = function(event)
        if not (event.data and event.data.client_id) then return end

        local buffer = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        require("lsp-inlayhints").on_attach(client, buffer)
      end,
    })
  end,
})

table.insert(extra_deps, { -- TypeScript
  { -- Magic real-time type tooltips with // ^?
    "marilari88/twoslash-queries.nvim",

    dependencies = {
      "neovim/nvim-lspconfig",
    },

    event = "FileType typescript,typescriptreact",

    keys = fox.keys.lazy({
      {
        "<C-S-i>",
        vim.cmd.TwoslashQueriesInspect,
        desc = "Inspect symbol under cursor",
      },
      {
        "<C-M-i>",
        vim.cmd.TwoslashQueriesRemove,
        desc = "Remove all inspectors in buffer",
      },
    }, {
      prefix = "TwoSlash queries: ",
      noremap = true,
      mode = "n",
    }),

    opts = {
      multi_line = true,
      highlight = "Type",
    },
  },
  { -- TSServer on sterroids
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
})

---@type Array<LazySpec>
return {
  { -- Mason
    "williamboman/mason.nvim",

    build = ":MasonUpdate",

    config = true,
  },

  { -- `mason-lspconfig`: Bridge the gap between Mason and LSPConfig
    "williamboman/mason-lspconfig.nvim",

    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "fmbarina/pick-lsp-formatter.nvim",

      "b0o/SchemaStore.nvim", -- JSON / YAML

      extra_deps,
    },

    config = function()
      local masonlsp = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local attach_formatter_on_save = function(client, buffer)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = FormatOnSave,
            buffer = buffer,
            callback = function()
              _G["PLF_SHOULD_OPEN_PICKER"] = false
              require("plf").format {
                async = false,
              }
              _G["PLF_SHOULD_OPEN_PICKER"] = true
            end,
          })
        end
      end

      masonlsp.setup {
        -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
        -- This setting has no relation with the `ensure_installed` setting.
        -- Can either be:
        --   - false: Servers are not automatically installed.
        --   - true: All servers set up via lspconfig are automatically installed.
        --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
        --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
        ---@type boolean | { exclude: string[] }
        automatic_installation = true,

        -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
        -- This setting has no relation with the `automatic_installation` setting.
        -- Get a list of available LSPs here: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
        ---@type string[]
        ensure_installed = {
          "bashls",
          "jsonls",
          "lua_ls",
          "marksman",
          "tsserver",
          "eslint",
          "vimls",
          "yamlls",
        },

        -- See `:h mason-lspconfig.setup_handlers()`
        ---@type table<string, fun(server_name: string)>?
        handlers = {
          function(name)
            lspconfig[name].setup {
              on_attach = attach_formatter_on_save,
              capabilities = capabilities,
            }
          end,

          ["jsonls"] = function()
            lspconfig.jsonls.setup {
              capabilities = capabilities,
              settings = {
                validate = { enable = true },
                schemas = require("schemastore").json.schemas {
                  extra = {
                    {
                      description = "Nodemon",
                      fileMatch = "nodemon.json",
                      name = "nodemon.json",
                      url = "https://json.schemastore.org/nodemon.json",
                    },
                  },
                },
              },
            }
          end,

          ["lua_ls"] = function()
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              on_attach = attach_formatter_on_save,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            }
          end,

          ["tsserver"] = function()
            local language_settings = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            }

            lspconfig.tsserver.setup {
              capabilities = capabilities,
              on_attach = function(client, buffer)
                require("twoslash-queries").attach(client, buffer)
                attach_formatter_on_save(client, buffer)
              end,
              init_options = {
                -- This is the default which would be overwritten otherwise
                hostInfo = "neovim",
                -- 16 gb
                maxTsServerMemory = 16384,
                -- Never use LSP for syntax anyway
                tsserver = { useSyntaxServer = "never" },
              },
              settings = {
                ["javascript"] = language_settings,
                ["typescript"] = language_settings,
                ["javascriptreeact"] = language_settings,
                ["typescriptreact"] = language_settings,
                diagnostics = {
                  ignoredCodes = {
                    "80006", -- "This may be converted to an async function" SHUT THE FUCK UP
                  },
                },
              },
            }
          end,

          ["eslint"] = function()
            lspconfig.eslint.setup {
              capabilities = capabilities,
              on_attach = function(_client, buffer)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  group = FixOnSave,
                  buffer = buffer,
                  command = "EslintFixAll",
                })
              end,
            }
          end,

          ["yamlls"] = function()
            lspconfig.yamlls.setup {
              capabilities = capabilities,
              on_attach = attach_formatter_on_save,
              settings = {
                yamml = {
                  schemaStore = {
                    enable = false,
                    url = "",
                  },
                  schemas = require("schemastore").yaml.schemas(),
                },
              },
            }
          end,
        },
      }
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",

    event = "Syntax *",

    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      local masonlsp = require("mason-null-ls")
      -- local null_ls = require("null-ls")
      -- local lspconfig = require("lspconfig")
      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()

      masonlsp.setup {
        -- stylua: ignore
        ensure_installed = {
          -- Formatters
          "prettierd",  -- HTML, CSS, TS/JS, JSON, YANL...
          "stylua",     -- Lua

          -- Linters
          "selene",       -- Lua
          "actionlint",   -- Github actions
          "vint",         -- VimScript
        },

        automatic_installation = true,

        -- See `:h mason-null-ls.nvim-handlers-usage`
        ---@type table<string, fun(server_name: string)>?
        handlers = {
          function(source, types)
            masonlsp.default_setup(source, types)
          end,
        },
      }
    end,
  },
}

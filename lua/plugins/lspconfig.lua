local fox = require("foxutils")

return {
  {
    "neovim/nvim-lspconfig",

    event = "Syntax *",

    dependencies = {
      { -- Get annotations in your Vim configurtation and plugin dev files
        "folke/neodev.nvim",
        config = true,
      },
    },

    config = function()
      -- Vim's default update time makes LSP functions very slow.
      -- 1/3 of a second makes it much more snappy, set it to a higher value
      -- for slower LSP analysis, but higher performance.
      vim.o.updatetime = 300

      -- Global mappings
      fox.keys.batch({
        noremap = {
          n = {
            { "Open diagnostics",         "<leader><S-d>", vim.diagnostic.open_float },
            { "Go to next diagnostic",    "<leader>dn",    vim.diagnostic.goto_next },
            { "Go to prev diagnostic",    "<leader>dp",    vim.diagnostic.goto_prev },
            { "Restart all atached LSPs", "<F12>",         vim.cmd.LspRestart },
          },
        },
      })

      -- Buffer specific settings
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeysOnAttach", {}),
        callback = function(ev)
          local buf = vim.lsp.buf

          local function async_format()
            buf.format({ async = true })
          end

          fox.keys.batch({
            noremap = {
              n = {
                { "Show documentation",   "<S-K>",      buf.hover },
                { "Show signature help",  "<C-K>",      buf.signature_help },
                { "Go to type",           "gt",         buf.type_definition },
                { "Go to definition",     "gd",         buf.definition },
                { "Go to declaration",    "gD",         buf.declaration },
                { "Go to implementation", "gi",         buf.implementation },
                { "Rename symbol",        "<leader>rn", buf.rename },
                { "Format document",      "<F10>",      async_format },
              },
              i = {
                { "Format document", "<F10>", async_format },
              },
            },
          }, {
            buffer = ev.buffer,
          })
        end,
      })
    end,
  },
  {
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
        "<M-i>",
        vim.cmd.TwoslashQueriesRemove,
        desc = "Remove all inspectors in buffer",
      },
    }, {
      prefix = "TwoSlash queries: ",
      noremap = true,
      mode = "n",
    }),

    config = function()
      local lspconfig = require("lspconfig")

      assert(lspconfig.tsserver, "TSServer is not installed, TwoSlash querries will be disabled.")

      require("twoslash-queries").setup({
        multi_line = true,
        highlight = "Type",
      })

      lspconfig.tsserver.setup({
        on_attach = function(client, bufno)
          require("twoslash-queries").attach(client, bufno)
        end,
      })
    end,
  },
}

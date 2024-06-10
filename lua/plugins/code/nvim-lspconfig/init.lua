local fox = require "foxutils"

local function plug(mod) return require("plugins.code.nvim-lspconfig." .. mod) end

---@type LazyPluginSpec
local spec = {
  "neovim/nvim-lspconfig",

  event = "Syntax *",

  dependencies = plug "deps",
  keys = fox.keys.lazy({
    {
      "<M-k>",
      vim.diagnostic.open_float,
      desc = "Open diagnostics for current line",
    },
    {
      "<leader>dn",
      vim.diagnostic.goto_next,
      desc = "Go to next diagnostic",
    },
    {
      "<leader>dp",
      vim.diagnostic.goto_prev,
      desc = "Go to prev diagnostic",
    },
    {
      "<F12>",
      vim.cmd.LspRestart,
      desc = "Restart all attached servers",
    },
  }, {
    prefix = "LSP: ",
    mode = "n",
  }),

  config = function()
    -- Vim's default update time makes LSP functions very slow.
    -- 1/3 of a second makes it much more snappy, set it to a higher value
    -- for slower LSP analysis, but higher performance.
    vim.o.updatetime = 300

    fox.keys.batch { -- Global mappings
      noremap = {
        n = {
          {
            "Open diagnostics",
            "<leader><S-d>",
            vim.diagnostic.open_float,
          },
          {
            "Restart all atached LSPs",
            "<F12>",
            vim.cmd.LspRestart,
          },
        },
      },
    }

    vim.api.nvim_create_autocmd("LspAttach", { -- Buffer specific settings
      group = vim.api.nvim_create_augroup("UserLspKeysOnAttach", {}),
      callback = function(ev)
        local buf = vim.lsp.buf
        local function async_format() require("plf").format { async = true } end
        local function pick_formatter() require("plf").pick_format() end

          -- stylua: ignore
          fox.keys.batch({
            noremap = {
              n = {
                { "Show documentation",       "<S-K>",   buf.hover },
                { "Show signature help",      "<C-K>",   buf.signature_help },
                { "Go to declaration",        "gD",      buf.declaration },
                { "Rename symbol",            "<F2>",    buf.rename },
                { "Format document",          "<F10>",   async_format },
                { "Select default formatter", "<C-F10>", pick_formatter },
              },
              i = {
                { "Format document",          "<F10>",   async_format },
                { "Select default formatter", "<C-F10>", pick_formatter },
              },
            },
          }, {
            buffer = ev.buffer,
          })
      end,
    })

    if vim.fn.has "nvim-0.10" == 1 then
      local InlayHintsToggle =
        vim.api.nvim_create_augroup("InlayHintsToggle", {})

      vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        group = InlayHintsToggle,
        callback = function() vim.lsp.inlay_hint.enable(false, { bufnr = 0 }) end,
      })
      vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        group = InlayHintsToggle,
        callback = function() vim.lsp.inlay_hint.enable(true, { bufnr = 0 }) end,
      })
    end
  end,
}

return spec

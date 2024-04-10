--[[
  DISCLAIMER:

  Those are very sensible configs.
  One mistake here could break the whole configuration chain.
  If you want to edit language-specific configs, check out these:
  - `plugins/lang/*/lspconfig.lua`
  - `plugins/mason/ensure-installed.lua`
--]]

local ensure_installed = require "plugins.code.mason.ensure-installed"

local mason = {
  -- Bridge the gap between Mason and LSPConfig
  "williamboman/mason-lspconfig.nvim",

  -- Plugins are loaded from highest priority to lowest
  ft = "*",
  priority = 1,

  dependencies = require "plugins.code.mason.deps",

  config = function()
    local masonlsp = require "mason-lspconfig"
    local lspconfig = require "lspconfig"
    local capabilities = require("coq").lsp_ensure_capabilities().capabilities

    local FormatOnSave = vim.api.nvim_create_augroup("FormatOnSave", {})
    local attach_formatter_on_save = function(client, buffer)
      if client.supports_method "textDocument/formatting" then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = FormatOnSave,
          buffer = buffer,
          callback = function()
            -- selene: allow(global_usage)
            _G["PLF_SHOULD_OPEN_PICKER"] = false
            require("plf").format {
              async = false,
            }
            -- selene: allow(global_usage)
            _G["PLF_SHOULD_OPEN_PICKER"] = true
          end,
        })
      end
    end

    local handlers = require "plugins.code.mason.handlers" {
      lspconfig = lspconfig,
      capabilities = capabilities,
      hook_fmt = attach_formatter_on_save,
    }

    masonlsp.setup {
      ---@type boolean | { exclude: string[] }
      automatic_installation = true,
      ensure_installed = ensure_installed["mason"],
      -- See `:h mason-lspconfig.setup_handlers()`
      handlers = handlers,
    }
  end,
}

local mason_null_ls = {
  "jay-babu/mason-null-ls.nvim",

  event = mason.event,
  priority = mason.priority + 1,

  dependencies = "williamboman/mason-lspconfig.nvim",

  config = function()
    local masonlsp = require "mason-null-ls"

    masonlsp.setup {
      -- stylua: ignore
      ensure_installed = ensure_installed['null-ls'],
      automatic_installation = true,
      handlers = {
        -- TODO: Copy auto handlers setup from Mason,
        --       Make it work with `nullconfig.lua files`
        function(source, methods) masonlsp.default_setup(source, methods) end,
      },
    }
  end,
}

local none_ls = {
  "nvimtools/none-ls.nvim",

  event = mason_null_ls.event,
  priority = mason_null_ls.priority + 1,

  dependencies = {
    "nvim-lua/plenary.nvim",
    "jay-babu/mason-null-ls.nvim",
  },

  config = true,
}

return {
  mason,
  mason_null_ls,
  none_ls,
}

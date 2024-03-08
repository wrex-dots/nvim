---@type HandlerModule
local M = {
  get_handler = function(T)
    return function()
      T.lspconfig.yamlls.setup {
        capabilities = T.capabilities,
        on_attach = T.hook_fmt,
        settings = {
          yaml = {
            schemaStore = {
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      }
    end
  end,
}

return M

---@class HandlerModule
local M = {
  get_handler = function(T)
    return function()
      T.lspconfig.jsonls.setup {
        capabilities = T.capabilities,
        on_attach = T.hook_fmt,
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
    end
  end,
}

return M

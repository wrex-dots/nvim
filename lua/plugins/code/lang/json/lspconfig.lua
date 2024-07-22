local ensure = require "plugins.code.lang.ensure-installed"
local server = "jsonls"

ensure["mason"]:add {
  server,
}

---@type LspHandlerFactory
local function factory(T)
  return function()
    T.lspconfig[server].setup {
      capabilities = T.capabilities,
      on_attach = T.default_on_attach,
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
end

return {
  [server] = factory,
}

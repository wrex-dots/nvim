local ensure = require "plugins.code.mason.ensure-installed"
local server = "jsonls"

ensure["mason"]:add {
  server,
}

---@type LspHandlerFactory
local function factory(T)
  return function()
    T.lspconfig[server].setup {
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
end

return {
  [server] = factory,
}

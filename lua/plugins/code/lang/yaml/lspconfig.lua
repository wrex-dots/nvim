local ensure = require "plugins.code.lang.ensure-installed"
local server = "yamlls"

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
end

return {
  [server] = factory,
}

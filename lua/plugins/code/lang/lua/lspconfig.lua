local ensure = require "plugins.code.mason.ensure-installed"
local server = "lua_ls"

---@type LspHandlerFactory
local function factory(T)
  return function()
    T.lspconfig[server].setup {
      capabilities = T.capabilities,
      on_attach = T.hook_fmt,
      settings = {
        Lua = {
          hint = { enable = true },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    }
  end
end

ensure["mason"]:add {
  server,
}

ensure["null-ls"]:add {
  "selene",
  "stylua",
}

return {
  [server] = factory
}

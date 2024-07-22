local ensure = require "plugins.code.lang.ensure-installed"
local server = "lua_ls"

ensure["mason"]:add {
  server,
}

ensure["null-ls"]:add {
  "selene",
  "stylua",
}

ensure["tree-sitter"]:add {
  "lua",
}

---@type LspHandlerFactory
local function factory(T)
  return function()
    T.lspconfig[server].setup {
      capabilities = T.capabilities,
      on_attach = T.default_on_attach,
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

return {
  [server] = factory,
}

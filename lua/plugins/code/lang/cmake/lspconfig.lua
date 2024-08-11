local ensure = require "plugins.code.lang.ensure-installed"

local lsp = "cmake-language-server"
local lintformat = "cmakelang"

ensure["null-ls"]:add {
  lsp,
  lintformat,
}

---TODO: Make that Null LS handler setup thing
---@type LspHandlerFactory
local function factory(T)
  T.lspconfig[lsp].setup {
    capabilities = T.capabilities,
    on_attach = T.default_on_attach,
    settings = {
      buildDirectory = "build/"
    }
  }
end

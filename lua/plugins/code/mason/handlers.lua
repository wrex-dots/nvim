local langs = require "plugins.code.lang"
local Handlers = {}

---@class LspConfigModule: table
---@field setup fun(opts?: table)

---@class LspConfigMain
---@field [string] LspConfigModule

---@alias LspHookFunction fun(client: lsp.Client, bufno: number)

---@class LspTools
---@field lspconfig    LspConfigMain
---@field hook_fmt     LspHookFunction
---@field capabilities unknown

---@alias LspHandlerFactory fun(T: LspTools): function
---@alias LspHandlerFactoryDict table<string, LspHandlerFactory>

---@type fun(module: string): LspHandlerFactoryDict
local function get(module)
  return require("plugins.code.lang." .. module .. ".lspconfig")
end

local function get_handlers(T)
  Handlers[1] = function(lang)
    T.lspconfig[lang].setup {
      on_attach = T.hook_fmt,
      capabilities = T.capabilities,
    }
  end

  for _, module in ipairs(langs) do
    local factories = get(module)
    if factories ~= true then
      for srv, factory in pairs(factories) do
        Handlers[srv] = factory(T)
      end
    end
  end

  return Handlers
end

return get_handlers

local langs = require("plugins.code.lang").langs
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

local function get_handlers(T)
  Handlers[1] = function(lang)
    T.lspconfig[lang].setup {
      on_attach = T.hook_fmt,
      capabilities = T.capabilities,
    }
  end

  for _, module in ipairs(langs) do
    ---@type LspHandlerFactoryDict
    local loaded, factories =
      pcall(require, "plugins.code.lang." .. module .. ".lspconfig")

    if loaded then
      if factories ~= true then
        for srv, factory in pairs(factories) do
          Handlers[srv] = factory(T)
        end
      end
    else
      print("Couldn't load LSP config for `" .. module .. "`!")
    end
  end

  return Handlers
end

return get_handlers

local langs = require("plugins.code.lang").langs
local Handlers = {}

---@class LspConfigModule: table
---@field setup fun(opts?: table)

---@class LspConfigMain
---@field [string] LspConfigModule

---@alias LspHookFunction fun(client: vim.lsp.Client, bufno: number)

---@class LspTools
---@field lspconfig         LspConfigMain
---@field default_on_attach LspHookFunction
---@field capabilities      unknown

---@alias LspHandlerFactory fun(T: LspTools): function
---@alias LspHandlerFactoryDict table<string, LspHandlerFactory>

local function get_handlers(T)
  vim.inspect(T)
  Handlers[1] = function(lang)
    T.lspconfig[lang].setup {
      on_attach = T.default_on_attach,
      capabilities = T.capabilities,
    }
  end

  for _, module in ipairs(langs) do
    ---@type LspHandlerFactoryDict
    local loaded, factories =
      pcall(require, "plugins.code.lang." .. module .. ".lspconfig")

    if loaded and (factories ~= true) then
      for srv, factory in pairs(factories) do
        Handlers[srv] = factory(T)
      end
    elseif vim.opt.verbose:get() > 0 then
      vim.notify(
        "No LSP configuration for language `" .. module .. "`",
        vim.log.levels.WARN
      )
    end
  end

  return Handlers
end

return get_handlers

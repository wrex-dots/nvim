local M = {}

local known_handlers = {
  "eslint",
  "jsonls",
  "lua_ls",
  "tsserver",
  "yamlls",
}

function M.get_handlers(T)
  local handlers = {
    function(lang)
      T.lspconfig[lang].setup {
        on_attach = T.hook_fmt,
        capabilities = T.capabilities,
      }
    end,
  }

  for _, i in pairs(known_handlers) do
    handlers[i] = require("lsphandlers." .. i).get_handler(T)
  end

  return handlers
end

return M

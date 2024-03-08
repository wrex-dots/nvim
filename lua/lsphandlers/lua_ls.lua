---@type HandlerModule
local M = {
  get_handler = function(T)
    return function()
      T.lspconfig.lua_ls.setup {
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
  end,
}

return M

local gFixOnSave = vim.api.nvim_create_augroup("FixOnSave", {})

---@class HandlerModule
local M = {
  get_handler = function(T)
    return function()
      T.lspconfig.eslint.setup {
        capabilities = T.capabilities,
        on_attach = function(_client, buffer)
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = gFixOnSave,
            buffer = buffer,
            command = "EslintFixAll",
          })
        end,
      }
    end
  end,
}

return M

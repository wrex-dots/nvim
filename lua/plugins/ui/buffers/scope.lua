-- LazyVim

---Restrict buffers' visibility to their own tabs
---@type LazyPluginSpec
local spec = {
  "tiagovla/scope.nvim",

  init = function()
    vim.opt.sessionoptions = { -- required
      "buffers",
      "tabpages",
      "globals",
    }
  end,

  config = true,
}

return spec

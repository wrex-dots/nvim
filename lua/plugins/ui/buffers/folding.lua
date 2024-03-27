---@type LazyPluginSpec
local spec = {
  "kevinhwang91/nvim-ufo",

  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-treesitter/nvim-treesitter",
  },

  event = "Syntax *",

  init = function()
    vim.o.foldcolumn = "0"
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,

  config = function()
    require("ufo").setup {
      provider_selector = function() return { "treesitter", "indent" } end,
    }
  end,
}

return spec

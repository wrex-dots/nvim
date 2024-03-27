---@type LazyPluginSpec
local spec = {
  "EdenEast/nightfox.nvim",

  lazy = false,
  priority = 100,

  init = function ()
    vim.cmd.colorscheme "duskfox"
  end,

  config = function()
    vim.o.termguicolors = true
    require("nightfox").setup {
      options = {
        transparent = true,
        dim_inactive = false,
        styles = {
          keywords = "bold",
          functions = "bold",
        },
      },
    }
  end,
}

return spec

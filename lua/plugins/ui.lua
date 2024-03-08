---@type LazySpec[]
local M = {}

table.insert(M, { -- Main colour theme
  "EdenEast/nightfox.nvim",

  lazy = false,
  priority = 100,

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
    vim.cmd.colorscheme("duskfox")
  end,
})

table.insert(M, { -- Automagically resize active split
  "anuvyklack/windows.nvim",

  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
  },

  config = true,
})

return M

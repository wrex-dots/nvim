---@type LazyPluginSpec
return {
  "windwp/nvim-projectconfig",

  lazy = false,

  priority = 99,

  opts = {
    silent = false,
    autocmd = true,
  },

  config = true,
}

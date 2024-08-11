---@type LazyPluginSpec
local spec = {
  "windwp/nvim-projectconfig",

  lazy = false,

  priority = 99,

  opts = {
    silent = false,
    autocmd = true,
    project_dir = vim.fs.joinpath(
      ---`stdpath('config')` returns a single string
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.fn.stdpath "config",
      "lua",
      "project-config"
    ),
  },

  config = true,
}

return spec

-- LazyVim

local exts = require "plugins.ui.apis.telescope.exts"

---@type LazyPluginSpec
local fzf = {
  "nvim-telescope/telescope-fzf-native.nvim",

  build = "make",

---@type LazyPlugin[]
return {
  fzf,
}

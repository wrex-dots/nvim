---@type LazySpec[]
local deps = {}

table.insert(deps, "nvim-telescope/telescope.nvim")

table.insert(deps, {
  "nvim-telescope/telescope-fzf-native.nvim",
  build = "make",
})

return deps

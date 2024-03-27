---@type LazyPluginSpec
local spec = {
  "williamboman/mason.nvim",

  build = ":MasonUpdate",

  config = true,
}

return spec

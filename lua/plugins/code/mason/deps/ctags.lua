local has = require "foxutils.systemhas"

---@type LazyPluginSpec
local spec = {
  -- Automatic ctags generation
  "JMarkin/gentags.lua",

  enabled = false, -- Getting errors on every single buffer write

  cond = has "ctags",

  dependencies = { "nvim-lua/plenary.nvim" },

  config = true,
}

return spec

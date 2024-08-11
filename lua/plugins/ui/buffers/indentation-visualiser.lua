---@type LazyPluginSpec
local spec = {
  "echasnovski/mini.indentscope",
  version = "*",
  opts = {
    draw = {
      priority = 50,
    },

    options = {
      indent_at_cursor = false,
    },
  },
}

return spec

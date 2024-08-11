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
      try_as_border = true,
    },
  },
}

return spec

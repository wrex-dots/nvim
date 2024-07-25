local fox = require "foxutils"

---@type LazyPlginSpec
local spec = {
  "cshuaimin/ssr.nvim",

  keys = function()
    local ssr = require "ssr"

    return fox.keys.lazy({
      {
        "<leader><S-r>",
        ssr.open,
        desc = "Structural Search and Replace (SSR)",
      },
    }, {
      mode = { "v", "n" },
      noremap = true,
    })
  end,
}

return spec

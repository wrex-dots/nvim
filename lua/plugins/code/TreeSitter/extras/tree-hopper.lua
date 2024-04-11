local fox = require "foxutils"

local spec = {
  "mfussenegger/nvim-treehopper",

  keys = function()
    local tsht = require "tsht"

    return fox.keys.lazy({
      {
        "<Space>",
        tsht.nodes,
        desc = "Select tree-sitter node",
      },
    }, {
      prefix = "TS Hopper: ",
      mode = { "n", "v", "o" },
      noremap = true,
    })
  end,
}

return spec

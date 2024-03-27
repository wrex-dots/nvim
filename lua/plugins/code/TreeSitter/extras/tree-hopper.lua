local fox = require "foxutils"

local spec = {
  "mfussenegger/nvim-treehopper",

  keys = "<Space>",

  config = function()
    local desc = "TS Hopper: Select node"
    local tsht = require "tsht"

    fox.keys.noremap.n(desc, "<Space>", tsht.nodes)
    fox.keys.noremap.o(desc, "<Space>", tsht.nodes)
  end,
}

return spec

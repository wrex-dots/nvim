local ensure = require "plugins.code.lang.ensure-installed"
local server = "csharp_ls"

ensure["mason"]:add {
  server,
}

ensure["tree-sitter"]:add {
  "c_sharp",
}

local ensure = require "plugins.code.lang.ensure-installed"
local server = "kotlin_language_server"

ensure["null-ls"]:add {
  server,
}

ensure["tree-sitter"]:add {
  "kotlin",
}

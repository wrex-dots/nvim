local ensure = require "plugins.code.lang.ensure-installed"
local server = "vimls"

ensure["mason"]:add {
  server,
}

ensure["null-ls"]:add {
  "vint",
}

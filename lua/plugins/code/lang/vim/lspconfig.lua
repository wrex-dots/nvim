local ensure = require "plugins.code.mason.ensure-installed"
local server = "vimls"

ensure["mason"]:add {
  server,
}

ensure["null-ls"]:add {
  "vint",
}

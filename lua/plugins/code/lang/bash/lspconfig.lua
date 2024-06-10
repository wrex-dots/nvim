local ensure = require "plugins.code.lang.ensure-installed"
local server = "bashls"

ensure["mason"]:add {
  server,
}

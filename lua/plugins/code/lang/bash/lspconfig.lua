local ensure = require "plugins.code.mason.ensure-installed"
local server = "bashls"

ensure["mason"]:add {
  server,
}

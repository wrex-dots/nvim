local ensure = require "plugins.code.mason.ensure-installed"
local server = "marksman"

ensure["mason"]:add {
  server,
}

local ensure = require "plugins.code.lang.ensure-installed"
local server = "marksman"

ensure["mason"]:add {
  server,
}

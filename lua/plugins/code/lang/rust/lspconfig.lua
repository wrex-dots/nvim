local ensure = require "plugins.code.lang.ensure-installed"

ensure["mason"]:add {
  "rust_analyzer",
}

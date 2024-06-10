local ensure = require "plugins.code.lang.ensure-installed"
local server = "marksman"

ensure["mason"]:add {
  server,
}

ensure["tree-sitter"]:add {
  "markdown",
  "markdown_inline",
  "vim",
  "vimdoc",
}

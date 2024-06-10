local ensure = require "plugins.code.lang.ensure-installed"

ensure["null-ls"]:add {
  "cmake-language-server", -- LSP
  "cmakelang", -- Formatter/Linter
}

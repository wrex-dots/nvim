---@type LazySpec[]
local ui = {
  require "plugins.ui.apis",

  require "plugins.ui.theme",

  require "plugins.ui.file-tree",
  require "plugins.ui.tab-bar",
  require "plugins.ui.terminal",

  require "plugins.ui.windows",
  require "plugins.ui.buffers",
}

return ui

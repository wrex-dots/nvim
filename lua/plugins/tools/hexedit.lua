local has = require "foxutils.systemhas"

return {
  "RaafatTurki/hex.nvim",

  -- This plugin needs xxd installed on your system
  cond = has "xxd",

  cmd = {
    "HexDump",
    "HexToggle",
  },

  config = true,
}

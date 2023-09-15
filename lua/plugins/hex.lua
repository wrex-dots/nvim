return {
  {
    'RaafatTurki/hex.nvim',

    -- This plugin needs xxd installed on your system
    cond = require('foxutils.systemhas')('xxd'),

    cmd = {
      'HexDump',
      'HexToggle',
    },

    config = true,
  }
}


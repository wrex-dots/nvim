local fox = require "foxutils"
--[[
     MAPLEADER:
     ==========

     Enables extra key combinations, like <leader>w to save

     Keybinds using <leader> need to be done in quick succession,
     while most other do not care about how fast or slow you perform them.
     I think there's an option to set that delay but I forgot its name
--]]
vim.g.mapleader = ","

--[[@overide
     V/H SPLIT CURSOR BEHAVIOUR:
     ==========

     Make cursor jump to new window when using <C-w>v and <C-w>s

     The default behaviour is for the cursor to stay in the current
     window while the split you just open is below or on the right.
     Most of the times it's not what you want, as you'll have to
     move to that window and then open a new buffer etc.
--]]
fox.keys.batch {
  map = {
    n = {
      {
        "Windows: Open a vertical split on the right",
        "<C-w>v",
        "<Cmd>belowright vsplit<Cr>",
        { silent = true },
      },
      {
        "Windows: Open a horizontal split on the right",
        "<C-w>s",
        "<Cmd>:belowright split<Cr>",
        { silent = true },
      },
    },
  },
}

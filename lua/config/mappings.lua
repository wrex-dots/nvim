local keys = require "foxutils.keys"
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
keys.batch {
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

--[[
     SUDO WRITE:
     ==========

     Enables calling sudo with an external askpass program in order to
     save buffer to a write-protected/root-owned file.

     Vim cannot provide text input for entering your sudo password, so
     it needs some GUI to do that in its stead.
     Requires $SSH_ASKPASS variable environment variable.
     @see https://wiki.archlinux.org/title/SSH_keys#x11-ssh-askpass
     @see https://wiki.archlinux.org/title/SSH_keys#Alternative_passphrase_dialogs
--]]
if vim.env.SSH_ASKPASS ~= nil then
  vim.env.SUDO_ASKPASS = vim.env.SSH_ASKPASS
  keys.map.n(
    "Write buffer using sudo",
    "<leader>sw",
    "<cmd>w !sudo -A tee %<cr>",
    { silent = true, noremap = true }
  )
end

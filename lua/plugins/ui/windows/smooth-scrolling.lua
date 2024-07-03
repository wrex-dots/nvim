-- LazyVim

local movement_keystrokes = {
  "#",
  "$",
  "*",
  "0",
  "<C-End>",
  "<C-Home>",
  "<C-b>",
  "<C-d>",
  "<C-e>",
  "<C-f>",
  "<C-i>",
  "<C-o>",
  "<C-u>",
  "<C-y>",
  "<PageDown>",
  "<PageUp>",
  "G",
  "N",
  "^",
  "g#",
  "g*",
  "gg",
  "gj",
  "gk",
  "h",
  "j",
  "k",
  "l",
  "n",
  "z+",
  "z-",
  "z.",
  "z<Cr>",
  "zH",
  "zL",
  "z^",
  "zb",
  "ze",
  "zh",
  "zl",
  "zs",
  "zt",
  "zz",
  "{",
  "}",
  "<Up>",
  "<Up>",
  "<Down>",
  "<Down>",
  "<Left>",
  "<Right>",
  -- B
  -- A
  -- <Start>
}

---@type LazyPluginSpec
local spec = {
  "declancm/cinnamon.nvim",

  keys = movement_keystrokes,

  ---@type CinnamonOptions
  opts = {
    keymaps = {
      basic = true,
      extra = true,
    },
  },

  config = true,
}

return spec

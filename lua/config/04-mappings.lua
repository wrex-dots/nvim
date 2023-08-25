--[[
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keybinds will be presented as such:                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MODES: Mappings' purpose
"
" <Keystroke>[<Additional keystrokes>...] [=> Action]
"
" [Optional complementary information]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Note: If a keybind uses Alt but you're on Mac, you can      "
" execute it by using Command instead of Alt.                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--]]

--[[
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mapleader
"
" Enables extra key combinations, like <leader>w to save
"
" Note: Keybinds using <leader> need to be done in
" quick succession, while most other do not care about how
" fast or slow you perform them.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--]]
vim.g.mapleader = ","

--[[
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NORMAL: How to exit vim
"
" <Ctrl+W><Q>       => Exit only if no buffer has unsaved changes
" <Ctrl+W><X>       => Save all changes and exit
" <Ctrl+W><Shift+Q> => Exits no matter what (risky)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--]]

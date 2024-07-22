-- Only have one statusbar at the bottom
vim.o.laststatus = 0

-- Use per-window top bar instead
-- It's the dim text you see atop your various windows/splits
--
-- Detailed explanation:
--    %n — Buffer number - you never know when you're gonna need them, but when you do you'll be happy they're there !
--    %= — Padding (next items are centered)
--    %f — Relative filename or as provided in the edit command
--    %m — Modified or unmodifiable flag
--    %= — Padding (next items are right aligned)
vim.o.winbar = [[%n%=%f%m%=L%l/%L:%c (%p%%)]]

-- Disable NVim's default ruler (we've got one in our winbar)
vim.o.ruler = false

--- This only sets things, no plugin spec
return {}

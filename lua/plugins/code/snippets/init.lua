local function plug(mod) return require("plugins.code.snippets." .. mod) end

local snippets = {
  plug "luasnip",
  plug "neogen",
}

return snippets

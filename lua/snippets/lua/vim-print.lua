local ls = require "luasnip"
local t = ls.text_node
local s = ls.snippet
local i = ls.insert_node

return {
  s({ trig = "v#print", snippetType = "autosnippet" }, {
    t "vim.print(",
    i(1, "data"),
    t ")",
  }),
}

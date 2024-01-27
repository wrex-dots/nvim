local ls = require "luasnip"
local t = ls.text_node
local s = ls.snippet
local i = ls.insert_node

return {
  s({ trig = "#json", snippetType = "autosnippet" }, {
    t "JSON.stringify(",
    i(1, "data"),
    t ", null, ",
    i(2, "2"),
    t ")",
  }),
}

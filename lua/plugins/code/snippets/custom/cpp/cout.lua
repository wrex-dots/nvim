local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {}, {
  s("cout<<", {
    t "std::cout << ",
    i(1, "data"),
    t " << std::endl;",
  }),
}

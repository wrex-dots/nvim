local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {}, {
  s(
    -- Use `.` because `"` automatically inserts a closing copy
    -- Mnemonic: `.` is generally used for relative paths
    [[#in.]],
    {
      t [[#include "]],
      i(1, "header.hpp"),
      t [["]],
    }
  ),
  s([[#in<]], {
    t [[#include <]],
    i(1, "header.hpp"),
    t [[>]],
  }),
}

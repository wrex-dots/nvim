---@type LazySpec
return { -- Toggle Visual-selected values like true/false
  "nguyenvukhang/nvim-toggler",

  keys = {
    "<leader>i",
  },

  opts = {
    inverses = { -- Custom inverses
      ["MIN"] = "MAX",
      ["ON"] = "OFF",
      ["based"] = "cringe",
      ["inner"] = "outer",
      ["min"] = "max",
      ["on"] = "off",
    },
  },
}

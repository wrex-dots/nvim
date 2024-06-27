---@type LazySpec
return { -- Toggle Visual-selected values like true/false
  "nguyenvukhang/nvim-toggler",

  keys = {
    "<leader>i",
  },

  opts = {
    inverses = {
      ["based"] = "cringe",
      ["inner"] = "outer",
      ["min"] = "max",
      ["MIN"] = "MAX",
      ["on"] = "off",
      ["ON"] = "OFF",
      ["yes"] = "no",
      ["YES"] = "NO",
      ["old"] = "new",
      ["OLD"] = "NEW",
      ["&&"] = "||",
      ["and"] = "or",
      ["AND"] = "OR",
    },
  },

  config = function(_self, opts) require("nvim-toggler").setup(opts) end,
}

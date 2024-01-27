return {
  "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",

  -- I find the colours being all over the place way too distracting
  -- However, if you like rainbow delimiters , you can switch this back to true.
  enabled = false,

  event = "Syntax *",

  config = function()
    local rainbow = require("rainbow-delimiters")
    local rds = require("rainbow-delimiters.setup")

    rds.setup {
      strategy = {
        [""] = rainbow.strategy[""],
        vim = rainbow.strategy[""],
      },
      query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
      },
      priority = {
        [""] = 110,
        lua = 210,
      },
      highlight = {
        "RainbowDelimiterYellow",
        "RainbowDelimiterOrange",
        "RainbowDelimiterRed",
        "RainbowDelimiterViolet",
        "RainbowDelimiterBlue",
        "RainbowDelimiterCyan",
        "RainbowDelimiterGreen",
      },
    }
  end,
}

local fox = require "foxutils"

---@type LazyPluginSpec
return {
  "SirWrexes/jest.nvim",
  -- Forked from: "mattkubej/jest.nvim"

  dir = "~/Repos/NvimPlugins/jest.nvim/",

  event = "BufEnter *.test.js,*.test.ts",

  keys = fox.keys.lazy({
    {
      "<leader>jj",
      vim.cmd.Jest,
      desc = "Run Jest on entire project",
    },
    {
      "<leader>jf",
      vim.cmd.JestFile,
      desc = "Run Jest on file in current buffer",
    },
    {
      "<leader>js",
      vim.cmd.JestSingle,
      desc = "Run Jest on test name under cursor",
    },
    {
      "<leader>jj",
      vim.cmd.JestCoverage,
      desc = "Run Jest on entire project with coverage",
    },
  }, { prefix = "Jest: ", mode = { "n", "v" }, noremap = true }),

  opts = {
    silent = false,
  },
}

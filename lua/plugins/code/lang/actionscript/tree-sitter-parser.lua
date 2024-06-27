local fox = require "foxutils"

---@type LazySpec
local tsparser = {
  "Rileran/tree-sitter-actionscript",

  ft = "actionscript",

  config = function(self)
    local psconf = require("nvim-treesitter.parsers").get_parser_configs()

    ---@type ParserInfo
    ---@diagnostic disable-next-line: inject-field
    psconf.actionscript = {
      maintainers = { "Rileran" },
      filetype = "actionscript",
      install_info = {
        url = self.dir,
        files = { vim.fs.normalize "src/parser.c" },
      },
    }

    if vim.fn.has "nvim-0.9" == 1 then
      vim.treesitter.language.register("actionscript", "actionscript")
    end
  end,
}

return {
  tsparser,
}

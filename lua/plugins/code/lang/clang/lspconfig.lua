local ensure = require "plugins.code.mason.ensure-installed"
local server = "clangd"

ensure["mason"]:add {
  server,
}

ensure["tree-sitter"]:add {
  "c",
  "cpp",
  "objc",
}

---@type fun(T: LspTools): fun(client: lsp.Client, buffer: integer) : nil
local function on_attach(T)
  return function(client, buffer)
    T.hook_fmt(client, buffer)

    local ih = require "clangd_extensions.inlay_hints"
    ih.setup_autocmd()
    ih.set_inlay_hints()
  end
end

---@type LspHandlerFactory
local function factory(T)
  return function()
    vim.opt.shellpipe = "| tee build_log.sh"

    local loaded, gt = pcall(require, "gentags")
    if loaded then gt.setup() end

    require("clangd_extensions").setup()

    T.lspconfig.clangd.setup {
      capabilities = T.capabilities,
      on_attach = on_attach,
    }
  end
end

return {
  [server] = factory,
}

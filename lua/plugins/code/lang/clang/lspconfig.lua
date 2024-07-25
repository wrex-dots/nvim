---LaziVim

local fox = require "foxutils"

local ensure = require "plugins.code.lang.ensure-installed"
local server = "clangd"

ensure["mason"]:add {
  server,
}

ensure["null-ls"]:add {
  "cpplint",
}

ensure["tree-sitter"]:add {
  "c",
  "cpp",
  "objc",
}

---@type fun(T: LspTools): LspHookFunction
local function on_attach(T)
  return function(client, buffer)
    T.default_on_attach(client, buffer)

    -- local ih = require "clangd_extensions.inlay_hints"
    -- ih.setup_autocmd()
    -- ih.set_inlay_hints()

    -- local confs = vim.fs.find(".clang-format", {
    --   type = "file",
    --   stop = vim.loop.os_homedir(),
    -- })
    --
    -- if not #confs ~= 0 then return end
    if not vim.loop.fs_stat(vim.fs.normalize "~/.clang-format") then return end

    if not fox.systemhas "yq" then
      vim.notify_once(
        "You should install `yq` to allow automatically setting buffer options based .clang-format settings. https://github.com/mikefarah/yq",
        vim.log.levels.INFO
      )
      return
    end

    local sysobj = vim
      .system(
        { "yq", ".TabWidth", vim.fs.normalize "~/.clang-format" },
        { text = true }
      )
      :wait()

    local twstr = sysobj.stdout
    if #twstr == 0 then return end

    local twval = tonumber(twstr)

    vim.o.shiftwidth = twval
    vim.o.tabstop = twval
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
      on_attach = on_attach(T),
    }
  end
end

return {
  [server] = factory,
}

local set_fillchar = require("plugins.ui.windows.splits").set_fillchar

local function get_fillchar()
  local fillchars = vim.o.fillchars

  local stl = vim.iter(fillchars:gmatch "stl:[^,]+,?"):next()
  local stlnc = vim.iter(fillchars:gmatch "stlnc:[^,]+,?"):next()
  if not stl or not stlnc then return "─" end

  local target = stl or stlnc
  return target:gsub("stln?c?:([^,]+),?", "%1")
end

---@type table<string, LspHookFunction>
local hooks = {
  format_on_save = function(client, buffer)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("FormatOnSave", {}),
        buffer = buffer,
        callback = function()
          -- TODO: Find some better way than using _G.
          --       Sadly, I couldn't get it to work yet.
          --       Probably some module with a local state variable + a getter/setter pair ?
          --
          -- selene: allow(global_usage)
          _G["PLF_SHOULD_OPEN_PICKER"] = false
          require("plf").format {
            async = false,
          }
          -- selene: allow(global_usage)
          _G["PLF_SHOULD_OPEN_PICKER"] = true
        end,
      })
    end
  end,

  statusline_context = function(client, buffer)
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, buffer)

      local fillchar = get_fillchar()

      local location = "v:lua.require'nvim-navic'.get_location()"
      local locationlen = string.format("len(%s)", location)

      local fillerlen = string.format("%d - %s", vim.o.columns - 1, locationlen)
      local filler = string.format("repeat('%s', %s)", fillchar, fillerlen)

      local status = "%#Title#%{%" .. location .. "%}"
      -- Filler disabled for now: See https://github.com/SmiteshP/nvim-navic/issues/148
      -- .. " %#StatusLine#%{"
      -- .. filler
      -- .. "}"

      set_fillchar " "
      vim.o.statusline = status
    end
  end,
}

---@type LspHookFunction
local function default_on_attach(client, buffer)
  vim
    .iter(pairs(hooks))
    :each(function(_, on_attach) on_attach(client, buffer) end)
end

return default_on_attach

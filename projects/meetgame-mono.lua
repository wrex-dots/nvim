vim.g.jest_cmd = "pnpm -C $(git rev-parse --show-toplevel)/common/tests/integration/bff test --"

---@diagnostic disable-next-line: unscoped_variables
MG = {}

function MG.StartBack()
  vim.cmd("botright vnew")
  vim.cmd.set("nomodified")
  vim.cmd.terminal("pnpm -w start:back")
  vim.cmd.normal("G")
  vim.cmd.wincmd("p")
end

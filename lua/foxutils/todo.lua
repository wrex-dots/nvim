local TODOS = {
  "conf: Simplify foxutils.keys.batch",
  "      |`- Use fox.keys.lazy wherever possible",
  "      |`- Set Jester keys",
  "       `- Cleanup NvimTree config's horrid key setup",
}

for _, todo in ipairs(TODOS) do
  vim.notify("[TODO] " .. todo, vim.log.levels.INFO)
end

local paths = {
  '~',
  '/home/',
  '/home/wrexes/.config/starship.toml',
  'fromage',
}

for _, path in ipairs(paths) do
  local r = vim.fn.isdirectory(path)
  if r then
    print(r .. ': ' .. path .. ' is a directory')
  else
    print(r .. ': ' .. path .. ' is NOT a directrory')
  end
end

if 0 then print('débile') end

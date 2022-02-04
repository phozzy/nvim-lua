local options = {
  signcolumn = 'yes',
  undofile = true,
  colorcolumn = '80',
  showtabline = 2,
  showmode = false,
  cmdheight = 2,
}
for k, v in pairs(options) do
  vim.opt[k] = v
end

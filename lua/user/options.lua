local options = {
  signcolumn = 'yes',
  undofile = true,
  colorcolumn = '80',
  showtabline = 2,
  showmode = false,
  cmdheight = 2,
  completeopt = { "menuone", "noselect" },
  timeoutlen = 1000,
  updatetime = 300,
  writebackup = false,
  cursorline = true,
  number = true,
  list = true,
}
for k, v in pairs(options) do
  vim.opt[k] = v
end

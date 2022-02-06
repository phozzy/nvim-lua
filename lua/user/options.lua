local options = {
  -- always show the sign column, otherwise it would shift the text each time
  signcolumn = 'yes',
  -- enable persistent undo
  undofile = true,
  -- Stop sign for lines greater than 80 symbols
  colorcolumn = '80',
  -- always show tabs
  showtabline = 2,
  -- we don't need to see things like -- INSERT -- anymore
  showmode = false,
  -- more space in the neovim command line for displaying messages
  cmdheight = 2,
  -- mostly just for cmp
  completeopt = { "menuone", "noselect" },
  -- time to wait for a mapped sequence to complete (in milliseconds)
  timeoutlen = 1000,
  -- faster completion (4000ms default)
  updatetime = 300,
  -- if a file is being edited by another program
  -- (or was written to file while editing with another program),
  -- it is not allowed to be edited
  writebackup = false,
  -- highlight the current line
  cursorline = true,
  -- set numbered lines
  number = true,
  -- show hidden symbols
  list = true,
  -- convert tabs to spaces
  expandtab = true,
  -- the number of spaces inserted for each indentation
  shiftwidth = 2,
  -- insert 2 spaces for a tab
  tabstop = 2,
  -- make indenting smarter again
  smartindent = true,
}
for k, v in pairs(options) do
  vim.opt[k] = v
end

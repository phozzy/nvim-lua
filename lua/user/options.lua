local options = {
  signcolumn = "yes",
  undofile = true,
  colorcolumn = "80",
}
for k, v in pairs(options) do
  vim.opt[k] = v
end

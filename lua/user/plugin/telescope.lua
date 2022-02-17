local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

-- local actions = require "telescope.actions"

telescope.setup{}
telescope.load_extension "file_browser"

--Add leader shortcuts
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader><space>', [[
  <cmd>lua require('telescope.builtin').buffers()<CR>
]], opts)
vim.api.nvim_set_keymap('n', '<leader>sf', [[
  <cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>
]], opts)
vim.api.nvim_set_keymap('n', '<leader>sb', [[
  <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>
]], opts)
vim.api.nvim_set_keymap('n', '<leader>sh', [[
  <cmd>lua require('telescope.builtin').help_tags()<CR>
]], opts)
vim.api.nvim_set_keymap('n', '<leader>st', [[
  <cmd>lua require('telescope.builtin').tags()<CR>
]], opts)
vim.api.nvim_set_keymap('n', '<leader>sd', [[
  <cmd>lua require('telescope.builtin').grep_string()<CR>
]], opts)
vim.api.nvim_set_keymap('n', '<leader>sp', [[
  <cmd>lua require('telescope.builtin').live_grep()<CR>
]], opts)
vim.api.nvim_set_keymap('n', '<leader>so', [[
  <cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>
]], opts)
vim.api.nvim_set_keymap('n', '<leader>?', [[
  <cmd>lua require('telescope.builtin').oldfiles()<CR>
]], opts)
vim.api.nvim_set_keymap('n', '<leader>fb', [[
  :Telescope file_browser
]], opts)

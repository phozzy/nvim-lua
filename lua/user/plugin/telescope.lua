local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

-- local actions = require "telescope.actions"

telescope.setup{}
telescope.load_extension "file_browser"

local function map(mode, lhs, rhs, opts)
    opts = vim.tbl_extend(
      'force',
      {noremap = true, silent = true},
      opts or {}
    )
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end
map(
  'n',
  '<leader><space>',
  '<cmd>lua require("telescope.builtin").buffers()<CR>'
)
map(
  'n',
  '<leader>sf',
  '<cmd>lua require("telescope.builtin").find_files({previewer = false})<CR>'
)
map(
  'n',
  '<leader>sb',
  '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>'
)
map(
  'n',
  '<leader>sh',
  '<cmd>lua require("telescope.builtin").help_tags()<CR>'
)
map(
  'n',
  '<leader>st',
  '<cmd>lua require("telescope.builtin").tags()<CR>'
)
map(
  'n',
  '<leader>sd',
  '<cmd>lua require("telescope.builtin").grep_string()<CR>'
)
map(
  'n',
  '<leader>sp',
  '<cmd>lua require("telescope.builtin").live_grep()<CR>'
)
map(
  'n',
  '<leader>so',
  '<cmd>lua require("telescope.builtin").tags{ only_current_buffer = true }<CR>'
)
map(
  'n',
  '<leader>?',
  '<cmd>lua require("telescope.builtin").oldfiles()<CR>'
)
map(
  'n',
  '<leader>fb',
  ':Telescope file_browser<CR>'
)

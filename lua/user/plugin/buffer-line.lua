local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup{
  options = {
    -- can be a string | function, see "Mouse actions"
    close_command = "Bdelete! %d",
    -- can be a string | function, see "Mouse actions"
    right_mouse_command = "Bdelete! %d",
    -- Set offset for NvimTree
    offsets = {
      {
        filetype = "NvimTree",
        text = function ()
          return vim.fn.getcwd()
        end,
        highlight = "Directory",
        text_align = "left",
      }
    },
    -- Allways show tab indicator
    show_tab_indicators = true,
    -- Add numbers to buffers
    numbers = "ordinal",
    -- Allways show bufferline
    always_show_bufferline = true,
  }
}

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
  ']b',
  ':BufferLineCycleNext<CR>'
)
map(
  'n',
  '[b',
  ':BufferLineCyclePrev<CR>'
)
for i = 1, 9, 1 do
  -- map buffers to numbers
  map(
    "n",
    "<leader>" .. i,
    "<cmd>BufferLineGoToBuffer " .. i .. "<CR>"
  )
end

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
        text = "",
        padding = 1,
      }
    },
    -- Allways show tab indicator
    show_tab_indicators = true,
  }
}

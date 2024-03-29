local M = {}

-- TODO: backfill this to template
M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {
      texthl = sign.name,
      text = sign.text,
      numhl = ""
    })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', [[
    <cmd>lua vim.lsp.buf.declaration()<CR>
  ]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', [[
    <cmd>lua vim.lsp.buf.definition()<CR>
  ]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', [[
    <cmd>lua vim.lsp.buf.hover()<CR>
  ]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', [[
    <cmd>lua vim.lsp.buf.implementation()<CR>
  ]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', [[
    <cmd>lua vim.lsp.buf.signature_help()<CR>
  ]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', [[
    <cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
  ]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', [[
    <cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
  ]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', [[
    <cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>
  ]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', [[
    <cmd>lua vim.lsp.buf.type_definition()<CR>
  ]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', [[
    <cmd>lua vim.lsp.buf.rename()<CR>
  ]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', [[
    <cmd>lua vim.lsp.buf.references()<CR>
  ]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', [[
    <cmd>lua vim.lsp.buf.code_action()<CR>
  ]], opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[
    <cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>
  ]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
  end
  lsp_keymaps(bufnr)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)

end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M

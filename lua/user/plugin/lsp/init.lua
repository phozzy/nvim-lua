local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

mason.setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
      },
  },
})

local status_ok, mason_tool_installer = pcall(require, "mason-tool-installer")
if not status_ok then
	return
end

mason_tool_installer.setup(
  {
    ensure_installed = {
      --LSP
      "lua-language-server",
      "luau-lsp",
      --DAP
      --Linter
      "luacheck",
      "misspell",
      --Formatter
      "luaformatter",
      "stylua",
    },
    -- set a delay (in ms) before the installation starts. This is only
    -- effective if run_on_start is set to true.
    -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
    -- Default: 0
    start_delay = 3000, -- 3 second delay
  }
)

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

mason_lspconfig.setup()

local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

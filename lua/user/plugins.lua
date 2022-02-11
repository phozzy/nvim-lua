local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- define a function to load plugin's config
local function safe_require_plugin_config(name)
  local ok_3f, val_or_err = pcall(require, ("lua.user.plugin." .. name))
  if not ok_3f then
    return print(("dotfiles error: " .. val_or_err))
  else
    return nil
  end
end

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  -- Have packer manage itself
  use "wbthomason/packer.nvim"
  -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/popup.nvim"
  -- Useful lua functions used by lots of plugins
  use "nvim-lua/plenary.nvim"

  -- Colorschemes
  use {
    "folke/tokyonight.nvim",
    opt = false,
    config = safe_require_plugin_config("tokyonight"),
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    opt = false,
    run = ":TSUpdate",
    config = safe_require_plugin_config("treesitter"),
  }

  -- Devicos
  use {
    "kyazdani42/nvim-web-devicons",
     opt = false,
    config = safe_require_plugin_config("devicons"),
  }

  -- cmp plugins
  -- The completion plugin
  use {
    "hrsh7th/nvim-cmp",
    opt = false,
    config = safe_require_plugin_config("cmp"),
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    }
  }
  -- buffer completions
  use "hrsh7th/cmp-buffer"
  -- path completions
  use "hrsh7th/cmp-path"
  -- cmdline completions
  use "hrsh7th/cmp-cmdline"
  -- snippet completions
  use "saadparwaiz1/cmp_luasnip"

  -- snippets
  --snippet engine
  use "L3MON4D3/LuaSnip"
  -- a bunch of snippets to use
  use "rafamadriz/friendly-snippets"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

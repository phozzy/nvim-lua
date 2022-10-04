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
  local ok_3f, val_or_err = pcall(require, ("user.plugin." .. name))
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
  -- Useful lua functions used by lots of plugins
  use "nvim-lua/plenary.nvim"
  -- Add :Bdelelet command
  use "moll/vim-bbye"
  -- Easily comment stuff
  use { "numToStr/Comment.nvim",
    opt = false,
    config = safe_require_plugin_config("comment"),
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    }
  }
  -- Easy to use terminal
  use { "akinsho/toggleterm.nvim",
    opt = false,
    config = safe_require_plugin_config("toggleterm"),
  }
  use { "lewis6991/impatient.nvim",
    opt = false,
    config = safe_require_plugin_config("impatient"),
  }

  -- Colorschemes
  use { "folke/tokyonight.nvim",
    opt = false,
    config = safe_require_plugin_config("tokyonight"),
  }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter",
    opt = false,
    run = ":TSUpdate",
    config = safe_require_plugin_config("treesitter"),
    requires = {
      "p00f/nvim-ts-rainbow",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-textobjects",
    }
  }
  -- Check for treesitter modules and plugins here:
  -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Extra-modules-and-plugins
  use { "p00f/nvim-ts-rainbow",
    opt = false,
  }
  use { "JoosepAlviste/nvim-ts-context-commentstring",
    opt = false,
  }
  use { "nvim-treesitter/nvim-treesitter-textobjects",
    opt = false,
  }

  -- Indentline
  use { "lukas-reineke/indent-blankline.nvim",
    opt = false,
    requires = {
      "nvim-treesitter/nvim-treesitter"
    },
    config = safe_require_plugin_config("indentline")
  }
  -- Devicos
  use { "kyazdani42/nvim-web-devicons",
    opt = false,
    config = safe_require_plugin_config("devicons"),
  }
  -- File browser
  use { "kyazdani42/nvim-tree.lua",
    opt =false,
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = safe_require_plugin_config("nvim-tree"),
  }
  -- Buffer line
  use { "akinsho/bufferline.nvim",
    opt =false,
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = safe_require_plugin_config("buffer-line"),
  }
  -- Status line
  use { "nvim-lualine/lualine.nvim",
    opt = false,
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    safe_require_plugin_config("lualine"),
  }
  -- Dashboard
  use { "goolord/alpha-nvim",
    opt = false,
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    safe_require_plugin_config("alpha"),
  }
  -- Whichkey - show poosible keybindings
  use { "folke/which-key.nvim",
    opt =false,
    safe_require_plugin_config("whichkey"),
  }

  -- cmp plugins
  -- The completion plugin
  use { "hrsh7th/nvim-cmp",
    opt = false,
    config = safe_require_plugin_config("cmp"),
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
    },
  }
  -- buffer completions
  use "hrsh7th/cmp-buffer"
  -- path completions
  use "hrsh7th/cmp-path"
  -- cmdline completions
  use "hrsh7th/cmp-cmdline"
  -- snippet completions
  use "saadparwaiz1/cmp_luasnip"
  -- lsp completion
  use "hrsh7th/cmp-nvim-lsp"
  -- source for neovim Lua API
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  --snippet engine
  use "L3MON4D3/LuaSnip"
  -- a bunch of snippets to use
  use "rafamadriz/friendly-snippets"

  -- Autopairs
  use { "windwp/nvim-autopairs",
    opt = false,
    requires = {
      "hrsh7th/nvim-cmp",
      "nvim-treesitter/nvim-treesitter",
    },
    config = safe_require_plugin_config("autopairs"),
  }

  -- LSP
  -- language server installer
  use { "williamboman/mason.nvim",
    opt = false,
  }
  -- Automatically install and update tools via Mason
  use { "WhoIsSethDaniel/mason-tool-installer.nvim",
    opt = false,
    requires = {
      "williamboman/mason.nvim",
    },
  }
  -- bridge between mason and lspconfig
  use { "williamboman/mason-lspconfig.nvim",
    opt = false,
    requires = {
      "WhoIsSethDaniel/mason-tool-installer",
    },
  }
  -- enable LSP
  use { "neovim/nvim-lspconfig",
    opt = false,
    requires = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = safe_require_plugin_config("lsp"),
  }
  -- for formatters and linters
  use { "jose-elias-alvarez/null-ls.nvim",
    opt = false,
    config = safe_require_plugin_config("null-ls"),
  }

  -- Debug Adapter Protocol
  use { "mfussenegger/nvim-dap",
    opt = false,
    config = safe_require_plugin_config("dap"),
  }
  use { "rcarriga/nvim-dap-ui",
    opt = false,
    requires = {
      "mfussenegger/nvim-dap",
    },
    config = safe_require_plugin_config("dap-ui"),
  }
  use { "leoluz/nvim-dap-go",
    opt = false,
    requires = {
      "mfussenegger/nvim-dap",
    },
    config = safe_require_plugin_config("dap-go"),
  }
  use { "jbyuki/one-small-step-for-vimkind",
    opt = false,
    requires = {
      "mfussenegger/nvim-dap",
    },
    config = safe_require_plugin_config("dap-lua"),
  }

  -- language tools
  -- Rust
  use { "simrat39/rust-tools.nvim",
    opt = false,
    requires = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    config = safe_require_plugin_config("rust-tools"),
  }
  -- Go language
  use { "ray-x/go.nvim",
    opt = false,
    config = safe_require_plugin_config("go-tools"),
  }

  -- Telescope
  use { "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = safe_require_plugin_config("telescope"),
  }
  use "nvim-telescope/telescope-file-browser.nvim"
  -- Mange projects
  use { "ahmedkhalf/project.nvim",
    opt =false,
    requires = {
      "nvim-telescope/telescope.nvim",
    },
    config = safe_require_plugin_config("project")
  }

  -- Git
  -- neogit
  use { "TimUntersberger/neogit",
    opt = false,
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = safe_require_plugin_config("neogit"),
  }
  -- gitsign
  use { "lewis6991/gitsigns.nvim",
    opt = false,
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = safe_require_plugin_config("gitsigns"),
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

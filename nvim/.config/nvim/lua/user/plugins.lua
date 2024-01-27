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

return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use "numToStr/Comment.nvim"
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"
  use "nvim-lualine/lualine.nvim"
  use "ahmedkhalf/project.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "folke/which-key.nvim"
  use "NvChad/nvim-colorizer.lua"
  use "sindrets/diffview.nvim"
  use "folke/zen-mode.nvim"
  use "ThePrimeagen/harpoon"
  use "ziontee113/color-picker.nvim"
  use "stevearc/dressing.nvim"
  use "saifulapm/chartoggle.nvim"
  use "kylechui/nvim-surround"
  use "folke/todo-comments.nvim"
  use "folke/trouble.nvim"
  use "RRethy/vim-illuminate"
  use "aserowy/tmux.nvim"
  use "is0n/fm-nvim"
  use "petertriho/nvim-scrollbar"
  use "folke/noice.nvim"
  use "MunifTanjim/nui.nvim"
  use "rcarriga/nvim-notify"
  use "jghauser/mkdir.nvim"
  use "kevinhwang91/nvim-bqf"
  use "olimorris/persisted.nvim"
  use "dnlhc/glance.nvim"
  use "LunarVim/bigfile.nvim"
  use "johmsalas/text-case.nvim"
  use "folke/neodev.nvim"
  use "axelvc/template-string.nvim"
  use "stevearc/oil.nvim"

  -- TODO: checkout
  -- use "pwntester/octo.nvim"
  -- use "ThePrimeagen/git-worktree.nvim"

  use {
    "kevinhwang91/nvim-ufo",
    requires = {
      "kevinhwang91/promise-async",
      "luukvbaal/statuscol.nvim",
    },
  }
  use {
    "asiryk/auto-hlsearch.nvim",
    tag = "1.0.0",
    config = function()
      require("auto-hlsearch").setup()
    end,
  }
  use {
    "utilyre/barbecue.nvim",
    requires = { "SmiteshP/nvim-navic" },
  }
  use {
    "b0o/schemastore.nvim",
    config = function()
      require("auto-hlsearch").setup()
    end,
  }

  -- Colorschemes
  use "lunarvim/colorschemes"
  use "NTBBloodbath/doom-one.nvim"
  use "folke/tokyonight.nvim"
  use "ellisonleao/gruvbox.nvim"
  use "sainnhe/gruvbox-material"
  use "lunarvim/darkplus.nvim"
  use "sainnhe/edge"
  use "jacoborus/tender.vim"
  use "shaunsingh/nord.nvim"
  use "sainnhe/everforest"
  use "sainnhe/sonokai"
  use "rebelot/kanagawa.nvim"
  use "titanzero/zephyrium"
  use "EdenEast/nightfox.nvim"
  use { "catppuccin/nvim", as = "catppuccin" }
  use { "projekt0n/github-nvim-theme", tag = "v0.0.7" }
  use "Mofiqul/vscode.nvim"
  use "ray-x/starry.nvim"
  use { "rose-pine/neovim", as = "rose-pine" }
  use "marko-cerovac/material.nvim"
  use "doums/darcula"
  use "voidekh/kyotonight.vim"
  use "windwp/nvim-autopairs"
  use "ChristianChiarulli/onedark.nvim"
  use { "decaycs/decay.nvim", as = "decay" }
  use { "bluz71/vim-nightfly-colors", as = "nightfly" }
  use { "bluz71/vim-moonfly-colors", as = "moonfly" }
  use "luisiacc/the-matrix.nvim"
  use "rafamadriz/neon"
  use "nyoom-engineering/oxocarbon.nvim"
  use "ishan9299/nvim-solarized-lua"
  use "kdheepak/monochrome.nvim"
  use "kvrohit/rasmus.nvim"
  use "Mofiqul/adwaita.nvim"
  use "kvrohit/mellow.nvim"
  use "Yazeed1s/oh-lucy.nvim"
  use "maxmx03/fluoromachine.nvim"
  use "ramojus/mellifluous.nvim"
  use "Shatur/neovim-ayu"
  use "Matsuuu/pinkmare"

  -- cmp plugins
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "FelipeLema/cmp-async-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-calc"
  -- use "jcha0713/cmp-tw2css"
  use "chrisgrieser/cmp-nerdfont"
  use "roobert/tailwindcss-colorizer-cmp.nvim"
  use "rasulomaroff/cmp-bufname"

  -- snippets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "tamago324/nlsp-settings.nvim"
  use "nvimtools/none-ls.nvim"
  use "simrat39/symbols-outline.nvim"
  use "rmagatti/goto-preview"
  use "VidocqH/lsp-lens.nvim"
  use "yioneko/nvim-vtsls"

  -- Dap
  use "mfussenegger/nvim-dap"
  use "rcarriga/nvim-dap-ui"
  use "leoluz/nvim-dap-go"
  use "theHamsta/nvim-dap-virtual-text"

  -- Mason
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  use "nvim-telescope/telescope.nvim"
  use {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "windwp/nvim-ts-autotag"
  -- use "HiPhish/rainbow-delimiters.nvim"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "2kabhishek/co-author.nvim"
  use "ruifm/gitlinker.nvim"
  use "NeogitOrg/neogit"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

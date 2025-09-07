-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


return require("lazy").setup({
    -- LSP support
    { "mason-org/mason.nvim", opts = {} },
    { "neovim/nvim-lspconfig" },

    -- Autocompletion sources
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "hrsh7th/cmp-buffer" },

    -- Fuzzy finding
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Rust <3
    {
        "mrcjkb/rustaceanvim",
        version = "^5", -- Recommended
        lazy = false,   -- This plugin is already lazy
    },

    -- Coq
    "whonore/Coqtail",

    -- Syntax highlighting
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- Movement
    {
        "theprimeagen/harpoon",
        branch = "harpoon2",
    },

    -- Quality of life
    "airblade/vim-gitgutter",
    "windwp/nvim-autopairs",
    "numToStr/Comment.nvim",

    -- Colorschemes
    "gbprod/nord.nvim",
    "folke/tokyonight.nvim",
    "navarasu/onedark.nvim",
    "neanias/everforest-nvim",
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lisp_fts = { 'clojure', 'fennel', 'racket', 'scheme', 'lisp' }

return require("lazy").setup({
    -- LSP support
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "neovim/nvim-lspconfig" },

    -- Autocompletion
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

    -- Git integration
    "airblade/vim-gitgutter",

    "windwp/nvim-autopairs",
    "numToStr/Comment.nvim",

    -- Colorschemes
    "gbprod/nord.nvim",
    "folke/tokyonight.nvim",
    "navarasu/onedark.nvim",
    "neanias/everforest-nvim",

    -- lispschemes
    -- all of these should only load for lisp filetypes so that loading one doesn't
    -- load any of the others. For example, even if Conjure is disaled for Rust,
    -- cmp-conjure or parinfer-rust might load it in the background if it's not
    -- disabled.
    {
        "Olical/conjure",
        ft = lisp_fts,
    },
    {
        "PaterJason/cmp-conjure",
        ft = lisp_fts,
    },
    {
        "eraserhd/parinfer-rust",
        build = "cargo build --release",
        ft = lisp_fts,
    },
})

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

return require("lazy").setup({
    -- LSP support
    {
        "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            -- LSP Support
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "neovim/nvim-lspconfig" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
        },
    },

    -- Fuzzy finding
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Rust <3
    "simrat39/rust-tools.nvim",

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
})

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- LSP support
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'neovim/nvim-lspconfig' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets (for some reason needed for autocomplete)
            { 'L3MON4D3/LuaSnip' }
        }
    }

    -- Fuzzy finding
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Rust <3
    use 'simrat39/rust-tools.nvim'

    -- Syntax highlighting
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')

    -- Movement
    use('theprimeagen/harpoon')

    -- Better undoing
    use('mbbill/undotree')

    -- Git integration
    use('tpope/vim-fugitive')
    use 'airblade/vim-gitgutter'

    use("windwp/nvim-autopairs")
    use 'numToStr/Comment.nvim'

    -- Colorschemes
    use 'shaunsingh/nord.nvim'
    use 'folke/tokyonight.nvim'
    use 'navarasu/onedark.nvim'

    -- Sync packer if this is the first time using it on system
    if packer_bootstrap then
        require('packer').sync()
    end
end)

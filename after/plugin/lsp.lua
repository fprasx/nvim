local capabilities = require('cmp_nvim_lsp').default_capabilities()


-- The base lsp keymaps we want. In a function so we can use it for normal lsp
-- setup and rust setup with rust-tools.nvim
function on_attach(_client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
        vim.api.nvim_command("write")
    end, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
        },
    },
})
vim.lsp.enable('lua_ls')

vim.lsp.config('hls', {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        haskell = {
            formattingProvider = "fourmolu",
        },
    },
})
vim.lsp.enable('hls')

vim.lsp.config('pylsp', {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        pylsp = {
            plugins = {
                ruff = {
                    enabled = true,
                    formatEnabled = true,
                    format = { "I" },
                    extendSelect = { "I" },
                },
            },
        },
    },
})
vim.lsp.enable('pylsp')

-- Handle Rust separately
vim.g.rustaceanvim = {
    -- LSP configuration
    server = {
        capabilities = capabilities,
        on_attach = on_attach,
        default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
                check = {
                    command = "clippy",
                },
                procMacro = {
                    enable = true,
                },
                diagnostics = {
                    disabled = {
                        "unresolved-proc-macro",
                    },
                },
            },
        },
    },
}

vim.diagnostic.config({
    virtual_text = true,
})

local cmp = require("cmp")
cmp.setup({
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer" },
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
})

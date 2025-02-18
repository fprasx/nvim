local lspconfig = require("lspconfig")

-- For some reason doesn't work when I stick it in the mason-lspconfig block
lspconfig.dafny.setup({
    on_attach = function(client, bufnr)
        vim.diagnostic.config({
            underline = false,
        }, bufnr)
        vim.cmd [[
            highlight! DiagnosticUnderlineError guibg=NONE gui=NONE
            highlight! DiagnosticUnderlineWarn  guibg=NONE gui=NONE
            highlight! DiagnosticUnderlineInfo  guibg=NONE gui=NONE
            highlight! DiagnosticUnderlineHint  guibg=NONE gui=NONE
        ]]
    end
})

require("mason").setup({})
require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            -- rust_analyzer setup is handled by rustaceanvim
            if server_name ~= "rust_analyzer" then
                lspconfig[server_name].setup({})
            end
        end,

        lua_ls = function()
            lspconfig.lua_ls.setup({
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
        end,

        hls = function()
            lspconfig.hls.setup({
                settings = {
                    haskell = {
                        formattingProvider = "fourmolu",
                    },
                },
            })
        end,

        pylsp = function()
            lspconfig.pylsp.setup({
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
        end,
    },
})

-- The base lsp keymaps we want. In a function so we can use it for normal lsp
-- setup and rust setup with rust-tools.nvim
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf, remap = false }
        vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format()
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
    end,
})

vim.diagnostic.config({
    virtual_text = true,
})

-- Set this up after lsp-zero
-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/autocomplete.md#introduction
local cmp = require("cmp")
cmp.setup({
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "conjure" }
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
})

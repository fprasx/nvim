require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "rust_analyzer", "lua_ls", "hls" },
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,

        lua_ls = function()
            require("lspconfig").lua_ls.setup({
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = {
                                vim.env.VIMRUNTIME,
                            }
                        }
                    }
                }
            })
        end,

        hls = function()
            require("lspconfig").hls.setup({
                settings = {
                    haskell = {
                        formattingProvider = "fourmolu",
                    },
                },
            })
        end,

        pylsp = function()
            require("lspconfig").pylsp.setup({
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

-- Do this after main lsp setup
local rt = require("rust-tools")
rt.setup({
    server = {
        on_attach = function(client, bufnr)
            base_lsp_maps(client, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- rust-actions
            vim.keymap.set("n", "<leader>ra", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
        settings = {
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

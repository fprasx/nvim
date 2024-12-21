require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'rust_analyzer', 'lua_ls', 'hls' },
})
local lsp = require("lsp-zero")

lsp.preset({})

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

lsp.configure("hls", {
    settings = {
        haskell = {
            formattingProvider = "fourmolu"
        }
    }
})

lsp.configure("pylsp", {
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

lsp.configure("gopls", {})
lsp.configure("ocamllsp", {})
lsp.configure("clangd", {})
lsp.configure("verible", {})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I",
    },
})

-- The base lsp keymaps we want. In a function so we can use it for normal lsp
-- setup and rust setup with rust-tools.nvim
local base_lsp_maps = function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
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
end

lsp.on_attach(base_lsp_maps)

-- Docs say to skip rust-analyzer setup because we do it with rust-tools. I've
-- acutally ignored that and it's fine. It has the benefit of still giving use
-- the commands from ^^ above.

lsp.setup()

-- Do this after main lsp setup
local rt = require("rust-tools")
rt.setup({
    server = {
        on_attach = function(client, bufnr)
            base_lsp_maps(client, bufnr)
            -- Hover actions
            vim.keymap.set(
                "n",
                "<C-space>",
                rt.hover_actions.hover_actions,
                { buffer = bufnr }
            )
            -- rust-actions
            vim.keymap.set(
                "n",
                "<leader>ra",
                rt.code_action_group.code_action_group,
                { buffer = bufnr }
            )
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
local cmp_action = require("lsp-zero").cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp_action.luasnip_supertab(),
    ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
})

cmp.setup({
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
    },
    mapping = mappings,
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
})

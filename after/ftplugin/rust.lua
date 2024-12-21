-- Do this after main lsp setup
vim.g.rustaceanvim = {
    -- LSP configuration
    server = {
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

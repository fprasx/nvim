vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(_)
        if vim.bo.ft == "dafny" then
            vim.cmd("syntax on")
        end
        -- Turn off annoying underlines from lsp
        vim.cmd [[
            highlight! DiagnosticUnderlineError guibg=NONE gui=NONE
            highlight! DiagnosticUnderlineWarn  guibg=NONE gui=NONE
            highlight! DiagnosticUnderlineInfo  guibg=NONE gui=NONE
            highlight! DiagnosticUnderlineHint  guibg=NONE gui=NONE
        ]]
    end,
})
vim.opt.shiftwidth = 2
vim.bo.commentstring =  "// %s"

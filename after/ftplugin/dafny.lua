vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(_)
        if vim.bo.ft == "dafny" then
            vim.cmd("syntax on")
        end
    end,
})

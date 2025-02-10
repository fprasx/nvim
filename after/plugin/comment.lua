require("Comment").setup({
    toggler = {
        line = "<leader>/",
    },
    opleader = {
        line = "<leader>/",
    },
    pre_hook = function ()
        if vim.bo.ft == "dafny" then
            return "//"
        end
    end
})

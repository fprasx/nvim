-- Reenable highlighting from Coqtail
vim.cmd([[hi def CoqtailChecked guibg=#113311]])

-- coq-check
vim.api.nvim_set_keymap('n', 'K', ":Coq Check <C-R>=expand('<cword>')<CR><CR>", { noremap = true, silent = true })
-- coq-got-def
vim.api.nvim_set_keymap('n', 'gd', ":CoqGotoDef <C-R>=expand('<cword>')<CR><CR>", { noremap = true, silent = true })

-- coq-to-line
vim.keymap.set("n", "<localleader>s", function()
    vim.cmd([[CoqToLine]])
    vim.api.nvim_command("write")
end)
-- coq-down
vim.keymap.set("n", "<Down>", function()
    vim.cmd([[CoqNext]])
end)
-- coq-up
vim.keymap.set("n", "<Up>", function()
    vim.cmd([[CoqUndo]])
end)

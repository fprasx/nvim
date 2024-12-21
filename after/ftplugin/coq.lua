Nord()
-- Reenable highlighting from Coqtail
vim.cmd([[hi def CoqtailChecked guibg=#113311]])

-- coq-to-line
vim.keymap.set("n", "<C-k>l", function() vim.cmd([[CoqToLine]]) end, opts)
-- coq-down
vim.keymap.set("n", "<Down>", function() vim.cmd([[CoqNext]]) end, opts)
-- coq-up
vim.keymap.set("n", "<Up>", function() vim.cmd([[CoqUndo]]) end, opts)

-- eval-show
-- just a rebinding of the action they provide, I couldn't figure out how to
-- change this variable:
-- https://github.com/Olical/conjure/blob/95b067e1356fb5b0143c9487ffc9950ddaa7df3a/doc/conjure.txt#L503
vim.keymap.set('n', "<localleader>es", function()
    vim.cmd([[ConjureEvalCommentRootForm]])
end)

-- Don't enable for non-lisp filetypes
vim.g["conjure#filetypes"] = { 'clojure', 'fennel', 'racket', 'scheme', 'lisp' }

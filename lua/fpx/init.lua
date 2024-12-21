require("fpx.set")
require("fpx.ft")
require("fpx.remap")
require("fpx.lazy")

vim.cmd([[
    if argc() == 1 && isdirectory(argv(0)) | cd `=argv(0)` | endif
]])

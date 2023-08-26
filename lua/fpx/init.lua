require("fpx.set")
require("fpx.remap")
require("fpx.packer")

vim.cmd [[
    if argc() == 1 && isdirectory(argv(0)) | cd `=argv(0)` | endif
]]

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
vim.keymap.set("i", "jw", "<Esc>")
vim.keymap.set("i", "jj", "<Esc>")
-- Exit insert mode and save the buffer - useful for reloading rust-analyzer output.
-- Mapped to <C-l> because that's convenient doesn't do anything :)
vim.keymap.set("i", "<C-l>", function()
    vim.api.nvim_command("write")
    vim.cmd("stopinsert")
end)

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Move around highlighted things
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in same place
vim.keymap.set("n", "J", "mzJ`z")

-- Don't move cursor when half-page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Moving through search results doesn't move cursor
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copying and pasting out of system keyboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+p]])

-- substitute-global
vim.keymap.set(
    "n",
    "<leader>sg",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)
-- substitute-line
vim.keymap.set(
    "n",
    "<leader>sl",
    [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)

-- Window movement
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<leader>wh", "<C-w>h")
vim.keymap.set("n", "<leader>wl", "<C-w>l")

-- Trigger writes from insert mode so rust-analyzer refreshes
-- vim.keymap.set("i", "<C-r>", function() vim.api.nvim_command("write") end);
vim.keymap.set("i", "<C-r>", "<Esc>:w<Enter>")

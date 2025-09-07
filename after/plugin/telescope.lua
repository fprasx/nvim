local builtin = require("telescope.builtin")
local actions = require('telescope.actions')

-- search-files
vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
-- search-back
vim.keymap.set("n", "<leader>sb", builtin.resume)
-- search-ripgrep
vim.keymap.set("n", "<leader>sr", builtin.live_grep)
-- search-term
vim.keymap.set("n", "<leader>st", function()
    builtin.grep_string({ search = vim.fn.input("[ Search ]: ") })
end)

-- TODO: figure out how to jump to next match
-- search-next
-- vim.keymap.set('n', '<leader>sn', function() actions.move_selection_next(0) end)
-- search-previous
-- vim.keymap.set('n', '<leader>sp', function() actions.move_selection_previous(0) end)

vim.keymap.set("n", "<C-p>", builtin.git_files, {})

require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
}

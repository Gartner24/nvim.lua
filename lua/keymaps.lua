local map = vim.keymap.set

-- comment line
vim.keymap.set("n", "gc", function()
  local line = vim.api.nvim_get_current_line()
  local indent, content = line:match("^(%s*)(.*)$")
  local comment_char = "#"

  if content:sub(1, #comment_char) == comment_char then
    -- Uncomment
    vim.api.nvim_set_current_line(indent .. content:sub(#comment_char + 1))
  else
    -- Comment
    vim.api.nvim_set_current_line(indent .. comment_char .. content)
  end
end, { noremap = true, silent = true })

-- Toggle relative numbers
map("n", "<leader>n", function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { silent = true })

-- Telescope & nvim-tree: keymaps in plugin specs (lazy-loaded)

-- Editing helpers
map("n", "<Esc>", ":noh<CR>", { silent = true })                 -- clear search highlight
map("n", "<leader>r", ":%s//g<Left><Left>", { noremap = true })
map("n", "<leader>w", ":w<CR>", { silent = true })               -- (fixed stray '>' in your old mapping)
map("n", "<leader>y", ":%y+<CR>", { silent = true })
-- Undotree: lazy in plugin spec
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { silent = true })

-- Harpoon: keymaps in plugin spec (lazy-loaded)

-- Zen Mode
map("n", "<leader>z", "<cmd>ZenMode<cr>", { silent = true })

-- Open Diagnostic
vim.keymap.set("n", "gl", function()
  vim.diagnostic.open_float(nil, { focus = false, border = "rounded", source = "if_many" })
end)

-- Open image
vim.keymap.set("n", "<leader>ip", function()
  require("utils.preview").preview_current_if_image()
end, { desc = "Preview current image (chafa)" })


-- prev and next buffer files
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true })
vim.keymap.set("n", "<Tab>", "<C-^>", { silent = true })

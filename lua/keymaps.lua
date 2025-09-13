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

-- Telescope (require inside the callback)
map("n", "<C-p>", function() require("telescope.builtin").find_files() end, {})
map("n", "<C-f>", function() require("telescope.builtin").live_grep() end, {})

-- nvim-tree
map("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })

-- Editing helpers
map("n", "<Esc>", ":noh<CR>", { silent = true })                 -- clear search highlight
map("n", "<leader>r", ":%s//g<Left><Left>", { noremap = true })
map("n", "<leader>w", ":w<CR>", { silent = true })               -- (fixed stray '>' in your old mapping)
map("n", "<leader>y", ":%y+<CR>", { silent = true })
map("n", "<leader>u", ":UndotreeToggle<CR>", { silent = true })

-- Harpoon 2
local function hp() return require("harpoon") end

-- add current file
map("n", "<leader>a", function() hp():list():add() end)


-- quick menu
map("n", "<leader>h", function() hp().ui:toggle_quick_menu(hp():list()) end)


-- jump to slots 1..4
map("n", "<A-1>", function() hp():list():select(1) end)
map("n", "<A-2>", function() hp():list():select(2) end)
map("n", "<A-3>", function() hp():list():select(3) end)
map("n", "<A-4>", function() hp():list():select(4) end)

-- remove current / clear all
map("n", "<leader>A", function() hp():list():remove() end)
map("n", "<leader>H", function() hp():list():clear() end)-- Zen Mode

-- Zen Mode
map("n", "<leader>z", ":ZenMode<CR>", { silent = true })

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

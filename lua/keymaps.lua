local map = vim.keymap.set

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

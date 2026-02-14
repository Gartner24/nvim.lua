-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- .templ filetype detection
vim.filetype.add({ extension = { templ = "templ" } })

-- Yank highlight (ThePrimeagen pattern)
local yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
	end,
})

-- UI
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

-- Clipboard: win32yank only in WSL; on native Linux use default (xclip/xsel/osc52)
vim.opt.clipboard = "unnamedplus"
if require("utils.env").is_wsl() then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = { ["+"] = "win32yank.exe -i --crlf", ["*"] = "win32yank.exe -i --crlf" },
		paste = { ["+"] = "win32yank.exe -o --lf", ["*"] = "win32yank.exe -o --lf" },
		cache_enabled = 0,
	}
end

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = [[%s/\s\+$//e]] })

-- Faster CursorHold so popups feel snappy
vim.o.updatetime = 250

-- Nice diagnostic UI + sane defaults
vim.diagnostic.config({
  virtual_text = false,

  signs = true,
  update_in_insert = false,
  float = {
    border = "rounded",
    source = "if_many",
    focusable = false,
  },
})


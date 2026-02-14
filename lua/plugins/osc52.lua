---OSC52 clipboard for VPS/SSH: copy from remote Neovim to local (Windows) clipboard.
---Only loads when NOT in WSL; in WSL we use win32yank instead.
return {
	"ojroques/nvim-osc52",
	cond = not require("utils.env").is_wsl(),
	config = function()
		local function copy(lines, _)
			require("osc52").copy(table.concat(lines, "\n"))
		end
		-- Paste: most terminals don't support OSC52 paste; use Ctrl+Shift+V in terminal
		local function paste()
			return { {}, "v" }
		end
		vim.g.clipboard = {
			name = "osc52",
			copy = { ["+"] = copy, ["*"] = copy },
			paste = { ["+"] = paste, ["*"] = paste },
		}
		vim.opt.clipboard = "unnamedplus"
	end,
}

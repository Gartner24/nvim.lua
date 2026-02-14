---OSC52 clipboard for VPS/SSH: copy from remote Neovim to local clipboard.
---Only loads when NOT in WSL; in WSL we use win32yank instead.
---Requires tmux: set -g allow-passthrough on (for tmux 3.3a+)
---Paste from outside: use Ctrl+Shift+V in terminal (OSC52 paste not widely supported)
return {
	"ojroques/nvim-osc52",
	cond = not require("utils.env").is_wsl(),
	config = function()
		require("osc52").setup({
			tmux_passthrough = true, -- required when using tmux with allow-passthrough on
		})
		-- Copy every yank to OSC52 (more reliable than clipboard provider)
		vim.api.nvim_create_autocmd("TextYankPost", {
			group = vim.api.nvim_create_augroup("osc52_yank", { clear = true }),
			callback = function()
				require("osc52").copy_register('"')
			end,
		})
		-- Don't set clipboard provider: it breaks p (paste returns empty).
		-- Use unnamed register only; yank still sends to OSC52 via autocmd above.
		vim.opt.clipboard = "unnamed"
	end,
}

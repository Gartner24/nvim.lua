---OSC52 clipboard: yank from any environment to the local terminal clipboard.
---Works on Arch, Ubuntu, VPS/SSH, and tmux. NOT loaded in WSL (win32yank handles that).
---Requires tmux: set -g allow-passthrough on (for tmux 3.3a+)
---Paste from outside: Ctrl+Shift+V in terminal (OSC52 paste is not widely supported).
---
---clipboard setting is handled in options.lua per environment:
---  - native Linux (wl-copy/xclip): unnamedplus — p/P uses system clipboard
---  - VPS/SSH (no tool):             unnamed     — p/P uses last-yank register
---OSC52 autocmd runs in both cases, exporting yanks to the terminal.
return {
	"ojroques/nvim-osc52",
	cond = not require("utils.env").is_wsl(),
	config = function()
		require("osc52").setup({
			tmux_passthrough = true, -- required when using tmux with allow-passthrough on
		})
		-- Export every yank to OSC52 so the local terminal receives it.
		vim.api.nvim_create_autocmd("TextYankPost", {
			group = vim.api.nvim_create_augroup("osc52_yank", { clear = true }),
			callback = function()
				require("osc52").copy_register('"')
			end,
		})
	end,
}

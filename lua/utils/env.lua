---Environment detection for conditional config (WSL vs native Linux vs VPS).

local M = {}

---Check if Neovim is running inside WSL (Windows Subsystem for Linux).
---@return boolean
function M.is_wsl()
	if vim.fn.has("wsl") == 1 then
		return true
	end
	-- Fallback: check kernel version for "microsoft" (WSL 2)
	local ok, uname = pcall(vim.loop.os_uname)
	if ok and uname and uname.release then
		return uname.release:lower():find("microsoft") ~= nil
	end
	return false
end

---Check if a system clipboard tool is available (wl-copy, xclip, xsel).
---True on local Arch/Ubuntu with a display server; false on headless VPS/SSH.
---@return boolean
function M.has_clipboard_tool()
	for _, cmd in ipairs({ "wl-copy", "xclip", "xsel", "pbcopy" }) do
		if vim.fn.executable(cmd) == 1 then
			return true
		end
	end
	return false
end

return M

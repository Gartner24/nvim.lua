---Environment detection for conditional config (WSL vs native Linux).
---Use this to skip WSL-specific settings when running on VPS / native Linux.

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

return M

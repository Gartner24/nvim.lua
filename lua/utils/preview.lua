-- lua/utils/preview.lua
local M = {}

local function is_image(p)
    p = (p or ""):lower()
    return p:match("%.png$") or p:match("%.jpe?g$") or p:match("%.gif$")
        or p:match("%.webp$") or p:match("%.bmp$") or p:match("%.svg$")
end

-- Open a centered, floating terminal that runs the renderer
local function open_float(w_ratio, h_ratio)
    local cols, lines = vim.o.columns, vim.o.lines
    local W = math.max(20, math.floor(cols * (w_ratio or 0.92)))
    local H = math.max(10, math.floor(lines * (h_ratio or 0.92)))

    local buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = "wipe"

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = W,
        height = H,
        col = math.floor((cols - W) / 2),
        row = math.floor((lines - H) / 2),
        style = "minimal",
        border = "rounded",
        noautocmd = true,
    })

    -- quick close
    vim.keymap.set("n", "q", function()
        if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    end, { buffer = buf, nowait = true, silent = true })
    vim.keymap.set("n", "<Esc>", function()
        if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    end, { buffer = buf, nowait = true, silent = true })

    return buf, win, W, H
end

function M.preview_image(path, opts)
    if not path or path == "" then return end
    path = vim.fn.fnamemodify(path, ":p")
    if not is_image(path) then
        vim.notify("Not an image: " .. path, vim.log.levels.INFO)
        return
    end

    local buf, _, W, H = open_float((opts and opts.w_scale) or 0.92, (opts and opts.h_scale) or 0.92)

    local has_viu = vim.fn.executable("viu") == 1
    local has_chafa = vim.fn.executable("chafa") == 1
    if not has_viu and not has_chafa then
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "No renderer found. Install `viu` or `chafa`." })
        return
    end

    -- Prefer `viu` (noticeably faster), fallback to `chafa`
    local cmd
    if has_viu then
        -- -b: best fit; -w/-h in cells; --static avoids animation overhead
        cmd = { "viu", "-b", "--static", "-w", tostring(W - 2), "-h", tostring(H - 2), path }
    else
        -- chafa: limit size and speed up rendering a bit
        cmd = { "chafa", "--animate", "off", "--color-space", "rgb", "-s", string.format("%dx%d", W - 2, H - 2), path }
    end
    -- Use small scrollback to avoid slow terminal buffers
    vim.bo[buf].scrollback = 100
    vim.fn.termopen(cmd)
    -- stay in normal mode (no startinsert) for instant display
end

function M.preview_current_if_image()
    local path = vim.api.nvim_buf_get_name(0)
    if is_image(path) then
        M.preview_image(path)
    else
        vim.notify("Current buffer is not an image", vim.log.levels.INFO)
    end
end

return M



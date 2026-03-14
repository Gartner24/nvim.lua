-- lua/utils/preview.lua
local M = {}

local function is_image(p)
    p = (p or ""):lower()
    return p:match("%.png$") or p:match("%.jpe?g$") or p:match("%.gif$")
        or p:match("%.webp$") or p:match("%.bmp$") or p:match("%.svg$")
end

--- Build cmd for viu or chafa. Used by preview_image and Telescope.
---@param path string
---@param opts? { w?: number, h?: number, fast?: boolean }  w/h for size; fast=true uses rgb+work 6
function M.image_cmd(path, opts)
    opts = opts or {}
    local has_viu = vim.fn.executable("viu") == 1
    local has_chafa = vim.fn.executable("chafa") == 1
    if has_viu then
        local args = { "viu", "-b", "-t" }  -- -t: preserve transparency
        if opts.w and opts.h then
            table.insert(args, "-w")
            table.insert(args, tostring(opts.w))
            table.insert(args, "-h")
            table.insert(args, tostring(opts.h))
        end
        table.insert(args, path)
        return args
    end
    if has_chafa then
        local args = { "chafa", "-f", "symbols" }
        if opts.w and opts.h then
            table.insert(args, "-s")
            table.insert(args, string.format("%dx%d", opts.w, opts.h))
        end
        table.insert(args, "--symbols")
        table.insert(args, "block")
        table.insert(args, "--dither")
        table.insert(args, "diffusion")
        table.insert(args, "--work")
        table.insert(args, opts.fast and "6" or "9")
        table.insert(args, "--color-space")
        table.insert(args, opts.fast and "rgb" or "din99d")
        table.insert(args, path)
        return args
    end
    return nil
end

-- Open a centered, floating terminal that runs the renderer
local function open_float(w_ratio, h_ratio)
    local cols, lines = vim.o.columns, vim.o.lines
    local W = math.max(20, math.floor(cols * (w_ratio or 0.92)))
    local H = math.max(10, math.floor(lines * (h_ratio or 0.92)))

    local buf = vim.api.nvim_create_buf(false, true)
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

    local cmd = M.image_cmd(path, { w = W - 2, h = H - 2 })
    if not cmd then
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "No renderer found. Install `viu` or `chafa`." })
        return
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



return {
    "nvim-telescope/telescope.nvim",
    version = "0.1.6", -- stable: master has mouse_click breakage; 0.1.7+ has path_expand/ft_to_lang issues
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find files" }, { "<C-f>", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Live grep" } },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local previewers = require("telescope.previewers")

        local function is_image(path)
            path = (path or ""):lower()
            return path:match("%.png$") or path:match("%.jpe?g$") or path:match("%.gif$")

                or path:match("%.webp$") or path:match("%.bmp$") or path:match("%.svg$")

        end

        -- 1) ENTER: float preview for images, normal open otherwise
        local function select_with_preview(prompt_bufnr)
            local entry = action_state.get_selected_entry()
            local path = entry and (entry.path or entry.filename or entry.value)
            if path and is_image(path) then
                actions.close(prompt_bufnr)
                require("utils.preview").preview_image(path)
            else
                actions.select_default(prompt_bufnr)
            end
        end


        -- 2) Inline preview pane renderer that keeps the buffer unmodified

        local builtin_maker = previewers.buffer_previewer_maker


        local function image_previewer_maker(filepath, bufnr, opts)
            filepath = vim.fn.expand(filepath)

            if not is_image(filepath) then
                return builtin_maker(filepath, bufnr, opts)
            end
            local cmd = require("utils.preview").image_cmd(filepath, { fast = true })
            if not cmd then
                return builtin_maker(filepath, bufnr, opts)
            end

            local winid = opts and opts.winid
            if not (winid and vim.api.nvim_win_is_valid(winid)) then
                return builtin_maker(filepath, bufnr, opts)
            end


            -- Skip if buffer is already a terminal (Telescope reuses buffers when scrolling fast)
            if vim.bo[bufnr].buftype == "terminal" then
                return -- leave previous image visible, avoid "Terminal already connected" error
            end
            vim.api.nvim_win_call(winid, function()
                if vim.api.nvim_get_current_buf() ~= bufnr then
                    vim.api.nvim_win_set_buf(0, bufnr)
                end
                vim.bo[bufnr].modifiable = true
                vim.bo[bufnr].readonly = false
                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {})
                vim.bo[bufnr].modified = false
                local ok = pcall(vim.fn.termopen, cmd)
                if not ok then
                    builtin_maker(filepath, bufnr, opts)
                end
            end)
        end

        telescope.setup({
            defaults = {
                file_ignore_patterns = { "venv", "env", "__pycache__", "%.pyc", "node_modules", "dist", "build" },
                buffer_previewer_maker = image_previewer_maker,
                preview = { treesitter = false }, -- disable: avoids ft_to_lang nil with nvim-treesitter main (gh#3487)
            },
            pickers = {
                find_files = {
                    hidden = true,
                    follow = true,
                    attach_mappings = function(_, map)
                        map("i", "<CR>", select_with_preview)
                        map("n", "<CR>", select_with_preview)
                        return true
                    end,
                },

                live_grep = {
                    attach_mappings = function(_, map)
                        map("i", "<CR>", select_with_preview)
                        map("n", "<CR>", select_with_preview)
                        return true
                    end,

                },
                buffers = {
                    attach_mappings = function(_, map)
                        map("i", "<CR>", select_with_preview)
                        map("n", "<CR>", select_with_preview)
                        return true

                    end,
                },
            },
        })
    end,
}


return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    -- floating image preview via chafa
    local function preview_image(path)
      local buf = vim.api.nvim_create_buf(false, true)
      local W = math.floor(vim.o.columns * 0.90)
      local H = math.floor(vim.o.lines * 0.90)
      local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor", width = W, height = H,
        col = math.floor((vim.o.columns - W) / 2),
        row = math.floor((vim.o.lines - H) / 2),
        style = "minimal", border = "rounded",
      })
      vim.keymap.set("n", "q", function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end, { buffer = buf, nowait = true, silent = true })
      vim.fn.termopen({ "chafa", "-s", string.format("%dx%d", W, H), path })
      vim.cmd("startinsert")
    end

    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },

      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        local function open_or_preview()
          local node = api.tree.get_node_under_cursor()
          if node and node.type == "file" then
            local name = (node.name or ""):lower()
            if name:match("%.png$") or name:match("%.jpe?g$")
               or name:match("%.gif$") or name:match("%.webp$")
               or name:match("%.bmp$") or name:match("%.svg$")
            then
              preview_image(node.absolute_path)
              return
            end
          end
          api.node.open.edit()
        end


        -- Enter: preview images / open others
        vim.keymap.set("n", "<CR>", open_or_preview,
          { buffer = bufnr, noremap = true, silent = true, nowait = true })

        -- p: force preview current node
        vim.keymap.set("n", "p", function()
          local n = require("nvim-tree.api").tree.get_node_under_cursor()
          if n and n.absolute_path then preview_image(n.absolute_path) end
        end, { buffer = bufnr, noremap = true, silent = true, nowait = true })
      end,
    })

  end,
}


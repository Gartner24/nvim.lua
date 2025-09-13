return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local preview = require("utils.preview").preview_image

    require("nvim-tree").setup({

      sync_root_with_cwd = true,
      respect_buf_cwd = true,

      update_focused_file = { enable = true, update_root = true },
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
              preview(node.absolute_path); return
            end
          end
          api.node.open.edit()
        end

        vim.keymap.set("n", "<CR>", open_or_preview,
          { buffer = bufnr, noremap = true, silent = true, nowait = true })

        vim.keymap.set("n", "p", function()
          local n = require("nvim-tree.api").tree.get_node_under_cursor()
          if n and n.absolute_path then preview(n.absolute_path) end
        end, { buffer = bufnr, noremap = true, silent = true, nowait = true })
      end,
    })
  end,
}


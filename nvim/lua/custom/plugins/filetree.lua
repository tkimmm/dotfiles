-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require('neo-tree').setup {
      -- source_selector = {
      -- winbar = true,
      -- statusline = true
      -- },
      close_if_last_window = false,
      name = {
        trailing_slash = true,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      window = {
        width = 30,
        mappings = {
          ["l"] = "toggle_node",
          ["h"] = "toggle_node",
          ["o"] = "open"
        }
      },
      filesystem = {
        follow_current_file = true,
      },
    }
  end,
}

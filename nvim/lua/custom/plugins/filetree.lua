return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      view = {
        width = 30,
        signcolumn = "yes",
        mappings = {
          list = {
          },
        },
      },
      renderer = {
        group_empty = true, -- default: true. Compact folders that only contain a single folder into one node in the file tree.
        highlight_git = false,
        full_name = true,
        highlight_opened_files = "icon", -- "none" (default), "icon", "name" or "all"
        highlight_modified = "icon",     -- "none", "name" or "all". Nice and subtle, override the open icon
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          -- webdev_colors = true,
          git_placement = "before",
          modified_placement = "after",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            modified = "",        -- default: ● - Rather change background color
            folder = {
              arrow_closed = "-", -- default: "",
              arrow_open = "+",   -- default: "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
      },
      filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = {},
        exclude = {},
      },
      git = {
        enable = false, -- default: true, however on large git project becomes very slow
      },
    }
  end,
}

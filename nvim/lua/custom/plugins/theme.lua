-- vim.cmd([[let g:sonokai_style = 'andromeda']])
-- vim.cmd([[let g:sonokai_better_performance = 1]])
return {

  -- {
  --   'sainnhe/sonokai',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'sonokai'
  --   end,
  -- }

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme "catppuccin"
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,    -- Force no italic
        no_bold = false,      -- Force no bold
        no_underline = false, -- Force no underline
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          notify = false,
          mini = false,
        },
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },
}

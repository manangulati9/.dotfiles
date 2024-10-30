return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    -- opts = {
    --   transparent_background = false,
    --   custom_highlights = function(colors)
    --     return {
    --       LineNrAbove = { fg = colors.overlay2 },
    --       LineNrBelow = { fg = colors.overlay2 },
    --     }
    --   end,
    --   highlight_overrides = {
    --     mocha = function()
    --       return {
    --         LineNr = { fg = "#FFFFFF" },
    --       }
    --     end,
    --   },
    -- },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}

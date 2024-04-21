return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {},
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
}

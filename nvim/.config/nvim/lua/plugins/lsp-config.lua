return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = false,
        analyses = {
          unusedparams = true,
        },
      },
    },
  },
}

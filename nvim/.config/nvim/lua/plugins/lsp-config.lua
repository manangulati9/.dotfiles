return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "jose-elias-alvarez/typescript.nvim",
    init = function()
      require("lazyvim.util").lsp.on_attach(function(_, buffer)
        vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
        vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
      end)
    end,
  },
  opts = {
    servers = {
      bashls = {},
      tsserver = {},
      cssls = {},
      dockerls = {},
      html = {},
      jsonls = {},
      prismals = {},
      vimls = {},
      gopls = {
        completeUnimported = true,
        usePlaceholders = false,
        analyses = {
          unusedparams = true,
        },
      },
      rust_analyzer = {},
      clangd = {},
      cmake = {},
      lua_ls = {},
      jdtls = {},
    },
  },
}

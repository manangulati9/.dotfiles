return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
      sh = { "shfmt" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      java = { "clang-format" },
      go = { "gofumpt", "goimports" },
      json = { "biome" },
    },
  },
}

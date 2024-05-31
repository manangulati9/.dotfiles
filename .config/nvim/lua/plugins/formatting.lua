return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      javascript = { { "biome", "prettierd", "prettier" } },
      typescript = { { "biome", "prettierd", "prettier" } },
      javascriptreact = { { "biome", "prettierd", "prettier" }, "rustywind" },
      typescriptreact = { { "biome", "prettierd", "prettier" }, "rustywind" },
      sh = { "shfmt" },
      c = { "clang-format" },
      cpp = { "clang-format" },
    },
  },
}

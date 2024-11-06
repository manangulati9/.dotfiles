---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require("conform")
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      javascript = { "biome", "prettierd", stop_at_first = true },
      typescript = { "biome", "prettierd", stop_at_first = true },
      javascriptreact = function(bufnr)
        return { first(bufnr, "biome", "prettierd"), "rustywind" }
      end,
      typescriptreact = function(bufnr)
        return { first(bufnr, "biome", "prettierd"), "rustywind" }
      end,
      sh = { "shfmt" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      java = { "clang-format" },
      go = { "gofumpt", "goimports" },
    },
  },
}

return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "html",
        "css",
        "javascript",
        "latex",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "tsx",
        "yaml",
        "typescript",
        "go",
        "rust",
        "c",
        "cpp",
        "java",
        "dockerfile",
        "prisma",
      })
    end,
  },
}

return {
  { import = "lazyvim.plugins.extras.lang.typescript" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "tsx",
        "vim",
        "yaml",
        "typescript",
        "go",
        "rust",
        "c",
        "cpp",
        "dockerfile",
      })
    end,
  },
}

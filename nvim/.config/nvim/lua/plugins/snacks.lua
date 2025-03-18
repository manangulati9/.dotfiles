return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    notifier = { top_down = false },
    picker = {
      sources = {
        explorer = {
          layout = { layout = { position = "right" } },
          ignored = true,
          hidden = true,
        },
      },
    },
  },
}

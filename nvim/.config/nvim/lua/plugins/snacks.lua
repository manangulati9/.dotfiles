return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
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

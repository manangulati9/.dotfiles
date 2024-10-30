return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    -- Set the colors
    -- vim.api.nvim_set_hl(0, "IblScope", { fg = "#ffffff" })
    -- vim.api.nvim_set_hl(0, "IblIndent", { fg = "#6c7086" })

    ---@module "ibl"
    ---@type ibl.config
    require("ibl").setup({
      scope = {
        show_start = false,
        show_end = false,
        -- highlight = "IblScope",
      },
      indent = {
        smart_indent_cap = true,
        tab_char = "▎",
        -- highlight = "IblIndent",
      },
    })
  end,
}

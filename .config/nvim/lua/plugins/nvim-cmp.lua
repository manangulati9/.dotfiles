local cmp = require("cmp")

return {
  "hrsh7th/nvim-cmp",
  opts = {
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    }),
  },
}

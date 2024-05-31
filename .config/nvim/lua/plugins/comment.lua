return {
  "numToStr/Comment.nvim",
  opts = {
    toggler = {
      ---Line-comment toggle keymap
      line = "<leader>/",
      ---Block-comment toggle keymap
      block = "<leader>b/",
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = "<leader>/",
      ---Block-comment keymap
      block = "<leader>b/",
    }, -- add any options here
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  },
  lazy = false,
}

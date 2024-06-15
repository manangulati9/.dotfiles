vim.opt.updatetime = 100

return {
  "echasnovski/mini.comment",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  version = false,
  opts = {
    mappings = {
      comment_line = "<leader>/",
      comment_visual = "<leader>/",
    },
    hooks = {
      pre = function()
        return vim.bo.commentstring
      end,
    },
  },
}

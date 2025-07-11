return {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
    config = function()
      --treesitter config
      local config = require("nvim-treesitter.configs")
      config.setup({
        ensure_installed = {"lua", "vue", "javascript", "typescript", "rust", "typst"},
        highlight = {enable = true},
        indent = {enable = true}
      })
    end
}

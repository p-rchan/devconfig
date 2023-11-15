return {
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.g.onedark_config = { style = 'deep' }
      -- vim.cmd( [[ colorscheme onedark ]] )
    end,
  },
  {
    -- Theme inspired by Atom
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
  },


}

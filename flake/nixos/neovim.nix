{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.neovim
  ];

  home.file."config/nvim/init.lua".text = ''
    vim.api.nvim_set_hl(0, "Normal", { bg = "#000000", fg = "#ffffff" })
    vim.opt.number = true
    vim.opt.relativenumber = false
    vim.opt.numberwidth = 2

    require('packer').startup(function()
        use 'kyazdani42/nvim-tree.lua'
    end)

    require'nvim-tree'.setup {
        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true,
        },
        view = {
            width = 30,
            side = 'left',
        },
    }

    vim.api.nvim_set_keymap('n', '<C-q>', ':NvimTreeToggle<CR>:file Files<CR>', { noremap = true, silent = true })
  '';
}

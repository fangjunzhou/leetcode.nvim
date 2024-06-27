{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins;[
    telescope-nvim
    plenary-nvim
    nui-nvim
    nvim-treesitter
    nvim-notify
    nvim-web-devicons
    (pkgs.vimUtils.buildVimPlugin {
      name = "leetcode.nvim";
      src = ./.;
    })
  ];
  extraConfigLua = builtins.readFile (./leetcode.lua);
}

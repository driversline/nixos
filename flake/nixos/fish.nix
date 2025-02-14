{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.fish
  ];

  home.file."config/fish/config.fish".text = ''
    if status is-interactive
        set -g fish_greeting ''
        set -g fish_disable_wildcard_expansion 1
        set -g fish_disable_history 1
    end

    function fish_prompt
        set_color white --bold
        set current_path (pwd)
        set home_path $HOME
        printf "[ %s ] ~> " (string replace -r "^$home_path" "/home" $current_path)
        set_color normal
    end

    function nvim
        command sudo -E nvim $argv
    end
  '';
}

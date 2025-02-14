{ config, pkgs, ... }:

{
  services.alacritty.config = ''
    [[keyboard.bindings]]
    action = "Copy"
    key = "C"
    mods = "Control"

    [[keyboard.bindings]]
    action = "Paste"
    key = "V"
    mods = "Control"

    [font]
    size = 10

    [font.normal]
    style = "Regular"
    family = "Cascadia Mono"

    [window]
    padding = { x = 3, y = 3 }

    [colors]
    [colors.primary]
    background = '0x000000'
  '';
}

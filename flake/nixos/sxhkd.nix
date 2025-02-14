{ config, pkgs, ... }:

{
  services.sxhkd.config = ''
    super + w
      alacritty
    super + q
      systemctl --user restart firefox.service
    super + d
      flameshot gui
    super + n
      alacritty -e ncmpcpp
    super + c
      alacritty -e cava
    super + l
      xset dpms force off
    super + o
      bspc wm -r
    super + p
      pkill -USR1 -x sxhkd
    super + x
      bspc node -c
    super + {Left,Right}
      bspc desktop -f {prev,next}
    super + alt + {Left,Right}
      bspc node -d {prev,next}
    ctrl + {Up,Down,Left,Right}
      bspc node -s {north,south,west,east}
    super + {Prior,Next}
      pactl set-sink-volume @DEFAULT_SINK@ {+5%,-5%}
    super + shift + {Prior,Next}
      mpc {prev,next}
    super + Return
      mpc toggle
    super + shift + {k,j}
      mpc repeat {on,off}
    super + a
      bspc node -t {tiled,floating}
  '';
}

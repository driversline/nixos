{ config, pkgs, ... }:

{

services.bspwm.config = ''
  #!/bin/sh
  bspc monitor -d I II III IV V
  bspc config focus_follows_pointer true
  bspc config pointer_follows_monitor true
  bspc config pointer_follows_focus true
  bspc config border_width 0
  bspc config normal_border_color "#ffffff"
  bspc config active_border_color "#ffffff"
  bspc config focused_border_color "#ffffff"
  bspc config urgent_border_color "#ffffff"
  bspc config window_gap 0
  bspc config ignore_ewmh_focus true
  bspc config merge_overlapping_monitors false
  bspc config center_pseudo_tiled false
  bspc config automatic_scheme alternate
  bspc config balance_sticky false
  bspc config swallow_first_child false
  bspc config initial_polarity second_child
  bspc config remove_disabled_monitors true
  bspc config remove_unplugged_monitors true
  bspc config normalize_border_on_focus false
  bspc config single_monocle true
  bspc config borderless_monocle true
  bspc config paddingless_monocle true
  bspc config gapless_monocle true
  bspc config click_to_focus false
  bspc mousebind super + right mouse resize
  bspc config split_ratio 0.5
  xset -dpms
  xset s off
  xsetroot -cursor_name left_ptr
  sxhkd -c $HOME/.config/bspwm/sxhkdrc &
  bspc rule -r \*
  bspc rule -a \* state=floating, rectangle=1200x600+360+240
  bspc rule -a Alacritty state=floating, rectangle=800x295+560+390
 '';

}

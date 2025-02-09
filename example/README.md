## Program links
[nvim](https://github.com/driversline/bspwm/blob/main/dotfiles/nvim/init.lua) - [alacritty](https://github.com/driversline/bspwm/blob/main/dotfiles/alacritty.toml) - [fish](https://github.com/driversline/bspwm/blob/main/dotfiles/fish/config.fish) - [gtk3](https://github.com/driversline/other/blob/main/gtk-3.0/settings.ini) - [gtk2](https://github.com/driversline/other/blob/main/.gtkrc-2.0) - [bspwmrc](https://github.com/driversline/bspwm/blob/main/dotfiles/bspwmrc) - [sxhkdrc](https://github.com/driversline/bspwm/blob/main/dotfiles/sxhkdrc)

### Don't forget to run
```bash
chmod +x ~/.config/bspwm/bspwmrc
```
<details>
     
<summary>## Copy files</summary>

```bash
curl -O https://raw.githubusercontent.com/driversline/other/main/.gtkrc-2.0 \
     -O https://raw.githubusercontent.com/driversline/other/main/gtk-3.0/settings.ini \
     -O https://raw.githubusercontent.com/driversline/bspwm/main/dotfiles/fish/config.fish \
     -O https://raw.githubusercontent.com/driversline/bspwm/main/dotfiles/alacritty.toml \
     -O https://raw.githubusercontent.com/driversline/bspwm/main/dotfiles/nvim/init.lua \
     -O https://raw.githubusercontent.com/driversline/bspwm/main/dotfiles/sxhkdrc \
     -O https://raw.githubusercontent.com/driversline/bspwm/main/dotfiles/bspwmrc
```
    
</details>

## Description
```bash
This configuration is intended for use with NVIDIA graphics (without integrated Intel graphics). Systemd-boot logs are completely hidden. Available locales are Russian/English. Swap is disabled. It uses the Zen kernel with minimal auditing. The default user is set to "user".
```

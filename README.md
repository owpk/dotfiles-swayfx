## <img src="./docs/sway-logo.png" width="36px" style="vertical-align:middle;"> My configs for [swayfx](https://github.com/WillPower3309/swayfx) (sway fork)

### ❤️ This dotfiles fully compatible with vanilla sway, just remove `./config/sway/config.d/swayfx` config file

#### Also check my '[sway keybindings helper](https://github.com/owpk/sway-keyhints)' project

<p align="center">
   <img src="./docs/composed2.jpg"/>
</p>

# 🗿 Info

- [sway fx (window manager)](https://github.com/WillPower3309/swayfx)
- [waybar (status bar)](https://github.com/Alexays/Waybar)
- [nwg-panel (status bar)](https://github.com/nwg-piotr/nwg-panel) Optional
- [nwg-launchers (menus/launchers)](https://github.com/nwg-piotr/nwg-launchers)
- [wofi (menus/launchers)](https://hg.sr.ht/~scoopta/wofi)
- [mako (wayland notification daemon)](https://github.com/emersion/mako)
- [avizo (wayland overlay bar)](https://github.com/misterdanb/avizo)
- [alacritty (shell)](https://github.com/alacritty/alacritty)
- [wf-recorder (screen recording)](https://github.com/ammen99/wf-recorder)
- [wl-clipboard (clipboard)](https://github.com/bugaevc/wl-clipboard)
- [swww (wallpaper daemon)](https://github.com/LGFae/swww)

# 🚀 Automatically installation

> (arch based distros)
> You can use installation script (using 'yay' package manager to resolve dependencies)

```bash
curl -L https://raw.githubusercontent.com/owpk/dotfiles-swayfx/main/install.sh | bash
```

# 🔧 Configuration

- default sway config: `~/.config/sway/config`

```
include $HOME/.config/sway/config.d/*
include /etc/sway/outputs/*
```

## status bar

- edit `~/.config/sway/config.d/10-autostart-applications` config file:

`waybar`

<p align="center">
   <img src="./docs/waybar.jpg"/>
</p>

> comment `nwg-panel` to enable `waybar`

```
#exec_always nwg-panel
```

`nwg-panel`

<p align="center">
   <img src="./docs/nwg-panel.jpg"/>
</p>

> comment `waybar` to enable `nwg-panel `

```
bar {
   #swaybar_command waybar
}
```

## keyboard

- edit `.config/sway/config.d/input` to change keyboard layout and other kb settings
- edit `.config/sway/config.d/default` to change key bindings config

## change output properties ([check man page for more info](https://manpages.debian.org/experimental/sway/sway-output.5.en.html))

- create config file in `/etc/sway/outputs/example`  
  example:

```
# Default wallpaper
output * scale 1.3
```

# Issues

- vmware: black screen after sway launch  
  adding WLR_NO_HARDWARE_CURSORS=1 to /etc/environment may fix the problem

---

<p align="center">
   <img src="./docs/sc.gif"/>
</p>

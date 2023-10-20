userresources=$HOME/.Xresources
[ -f "$userresources" ] && xrdb -merge "$userresources"

# set PATH
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/Applications" ] && PATH="$HOME/Applications:$PATH"
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"
[ -d "$HOME/.local/scripts" ] && PATH="$HOME/.local/scripts:$PATH"

# exports
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# Prepend a custom font path to Xorg's list of known font paths
xset +fp $HOME/.fonts 

xset r rate 210 40
numlockx on
setxkbmap -layout us,ara -variant dvorak,digits -option grp:alt_space_toggle caps:swapescape

feh --bg-fill $HOME/Pictures/wallpaper.png &
# dbus-launch dunst --config ~/.config/dunst/dunstrc &
# redshift &
mpd &
sxhkd &
dunst &
picom &

exec dwm

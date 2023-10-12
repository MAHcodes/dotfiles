set -g -x fish_greeting ''
set budspencer_colors ECEFF4 5c6370 666666 ffffff 61afef 56b6c2 ff0033 ff6600 d19a66 98c379 e06c75 c678dd
set -g theme_display_pwd_on_first_line yes
set -g theme_display_git_on_first_line yes
set -g theme_display_ruby no
set -g theme_display_node yes
set -gx EDITOR nvim

#https://wiki.archlinux.org/title/GNOME/Keyring#Using_the_keyring_outside_GNOME
if test -n "$DESKTOP_SESSION"
    set -x (gnome-keyring-daemon --start | string split "=")
end

# suckless patching alias
alias slmake="rm -rf config.h; sudo make clean install; make clean"

# History in cache directory:
HISTSIZE=1000000
SAVEHIST=1000000

# Default Apps
export EDITOR="nvim"
export VISUAL="nvim"
export READER="zathura"
export TERMINAL="kitty"
export BROWSER="brave-browser"
export VIDEO="mpv"
export IMAGE="sxiv"
export COLORTERM="truecolor"
export OPENER="xdg-open"
export PAGER="less"
# export WM="dwm"
export MANPAGER='nvim +Man!'

# export fnm path
[ -d "$HOME/.local/share/fnm" ] && PATH="$HOME/.local/share/fnm:$PATH"

# export deno path
[ -d  "$HOME/.deno/bin" ] && PATH="$HOME/.deno/bin:$PATH"]

# export go path
export GOPATH="$HOME/go"
export GOROOT="$HOME/.go"
[ -d "$HOME/go/bin" ] && PATH="$HOME/go/bin:$PATH"]

# pnpm
export PNPM_HOME="/home/mhmdali102/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# vivid generate catppuccin-mocha theme
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# fzf catppuccin_mocha
export FZF_DEFAULT_OPTS=" \
--border=rounded --margin=0,1 --padding=0 --info=inline --prompt=' ' --ansi --no-mouse --reverse \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#b4befe,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#b4befe,hl+:#f38ba8 \
--bind 'ctrl-d:change-prompt( )+reload(fd . --type d)' \
--bind 'ctrl-f:change-prompt( )+reload(fd . --type f)'"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

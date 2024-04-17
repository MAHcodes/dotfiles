# History in cache directory:
HISTSIZE=1000000
SAVEHIST=1000000

# Default Apps
export EDITOR="nvim"
export VISUAL="nvim"
export READER="zathura"
export TERMINAL="wezterm"
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

# export mise shims path
[ -d  "$HOME/.local/share/mise/shims" ] && PATH="$HOME/.local/share/mise/shims:$PATH"]

# export luarocks path
[ -d  "$HOME/.luarocks/bin" ] && PATH="$HOME/.luarocks/bin:$PATH"]

# completions
# [ -s "$HOME/.config/zsh/completions/_bun" ] && source "$HOME/.config/zsh/completions/_bun"
# [ -s "$HOME/.config/zsh/completions/_when" ] && source "$HOME/.config/zsh/completions/_when"

# atuin
# eval "$(atuin init zsh)"

# pnpm
export PNPM_HOME="/home/mhmdali102/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# vivid generate theme
export LS_COLORS="$(vivid generate rose-pine)"

# fzf
export FZF_DEFAULT_OPTS=" \
--border=none --margin=0 --padding=0 --info=inline --prompt=' ' --ansi --no-mouse --reverse \
	--color=fg:#908caa,bg:#191724,hl:#ebbcba \
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba \
	--color=border:#403d52,header:#31748f,gutter:#191724 \
	--color=spinner:#f6c177,info:#9ccfd8 \
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa \
--bind 'ctrl-d:change-prompt( )+reload(fd . --type d)' \
--bind 'ctrl-f:change-prompt( )+reload(fd . --type f)'"

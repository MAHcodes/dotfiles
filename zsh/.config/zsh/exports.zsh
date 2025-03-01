# History
HISTSIZE=1000000
SAVEHIST=1000000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups

# Default Apps
export EDITOR="nvim"
export VISUAL="nvim"
export READER="zathura"
export TERMINAL="wezterm"
export BROWSER="zen"
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

# export nvim-bob path
[ -d  "$HOME/.local/share/bob/nvim-bin" ] && PATH="$HOME/.local/share/bob/nvim-bin:$PATH"]

# atuin
# eval "$(atuin init zsh)"

# ruby
# eval "$(rbenv init -)"

# pnpm
export PNPM_HOME="/home/mhmdali102/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# vivid generate theme
export LS_COLORS="$(vivid generate catppuccin-mocha)"

# fzf
export FZF_DEFAULT_OPTS=" \
--border=none --margin=0 --padding=0 --info=inline --prompt=' ' --ansi --no-mouse --reverse \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#b4befe,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#b4befe,hl+:#f38ba8 \
--bind 'ctrl-d:change-prompt( )+reload(fd . --type d)' \
--bind 'ctrl-f:change-prompt( )+reload(fd . --type f)'"

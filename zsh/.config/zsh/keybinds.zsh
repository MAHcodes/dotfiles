bindkey '^[e' autosuggest-execute
bindkey '^[a' autosuggest-accept

zle -N history-substring-search-up
zle -N history-substring-search-down
bindkey -M vicmd 'p' history-substring-search-up
bindkey -M vicmd 'n' history-substring-search-down

# Edit line in vim with alt+v
export VISUAL=nvim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

bindkey -s '^f' 'lfcd\n'
bindkey -s '^u' 'tmux-sessionizer\n'
bindkey -s '^p' 'fzcdproj\n'

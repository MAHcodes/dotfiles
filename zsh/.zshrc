[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/keybinds.zsh"
plug "$HOME/.config/zsh/functions.zsh"

# Completion paths must be on fpath before compinit runs (supercharge), so
# zsh-completions and the local completions dir are registered first.
plug "zsh-users/zsh-completions"
fpath+=~/.config/zsh/completions

# plugins
plug "zap-zsh/supercharge" # runs compinit
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "Aloxaf/fzf-tab" # must load after compinit
plug "Freed-Wu/fzf-tab-source"
plug "zsh-users/zsh-history-substring-search"
plug "zap-zsh/vim"
plug "paulirish/git-open"
plug "MenkeTechnologies/zsh-expand"
plug "zap-zsh/magic-enter"
plug "MAHcodes/bgnotify.zsh"

# prompts
plug "zap-zsh/zap-prompt"

# Hermes Agent command
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac

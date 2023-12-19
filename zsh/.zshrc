[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/keybinds.zsh"
plug "$HOME/.config/zsh/functions.zsh"

# plugins
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-completions"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/fzf"
plug "Aloxaf/fzf-tab"
plug "Freed-Wu/fzf-tab-source"
plug "zsh-users/zsh-history-substring-search"
plug "zap-zsh/vim"
plug "wintermi/zsh-fnm"
plug "zap-zsh/exa"
plug "paulirish/git-open"
plug "MenkeTechnologies/zsh-expand"
plug "zap-zsh/magic-enter"

# prompts
plug "zap-zsh/zap-prompt"
# plug "MAHcodes/distro-prompt"
# plug "romkatv/powerlevel10k"

# autocomplete
fpath+=~/.config/zsh/completions
autoload -Uz compinit && compinit

# bun completions
[ -s "/home/mhmdali102/.bun/_bun" ] && source "/home/mhmdali102/.bun/_bun"

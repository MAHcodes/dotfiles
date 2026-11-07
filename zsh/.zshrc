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

# eza aliases (previously the zap-zsh/exa plugin). Defined after supercharge so
# they are not overwritten by its plain `ls --color=auto` alias. Uses the
# builtin $commands lookup to avoid an `eza --version` subprocess at startup.
if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='ls -lh --git'
  alias la='ll -a'
  alias tree='ll --tree --level=2'
fi

plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "Aloxaf/fzf-tab" # must load after compinit
plug "Freed-Wu/fzf-tab-source"
plug "zsh-users/zsh-history-substring-search"
plug "zap-zsh/vim"
plug "paulirish/git-open"
plug "MenkeTechnologies/zsh-expand"
plug "zap-zsh/magic-enter"

# prompts
plug "zap-zsh/zap-prompt"
# plug "MAHcodes/distro-prompt"
# plug "romkatv/powerlevel10k"

# Removed for startup speed:
# - zap-zsh/fzf: keybinds.zsh already runs `eval "$(fzf --zsh)"`
# - wintermi/zsh-fnm: no-op unless fnm is installed
# - zap-zsh/exa: aliases are defined above after supercharge (avoids an
#   `eza --version` subprocess)
#
# compinit is handled by supercharge. Running it a second time here only
# re-scanned fpath and cost ~20ms. Run `compinit` manually after adding new
# completion files if you need them registered immediately.

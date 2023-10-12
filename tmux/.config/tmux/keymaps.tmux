# open pane in current path
bind  c  new-window      -c "#{pane_current_path}"
bind  %  split-window -h -c "#{pane_current_path}"
bind '"' split-window -v -c "#{pane_current_path}"

# vim-like navigation
set -g @tmux-nvim-navigation true
set -g @tmux-nvim-navigation-cycle true
set -g @tmux-nvim-navigation-keybinding-left 'C-h'
set -g @tmux-nvim-navigation-keybinding-down 'C-j'
set -g @tmux-nvim-navigation-keybinding-up 'C-k'
set -g @tmux-nvim-navigation-keybinding-right 'C-l'

# vim-like resizing
set -g @tmux-nvim-resize true
set -g @tmux-nvim-resize-step-x 1
set -g @tmux-nvim-resize-step-y 1
set -g @tmux-nvim-resize-keybinding-left 'M-h' 
set -g @tmux-nvim-resize-keybinding-down 'M-j' 
set -g @tmux-nvim-resize-keybinding-up 'M-k' 
set -g @tmux-nvim-resize-keybinding-right 'M-l' 

# vim-like yank
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

# tools
bind g new-window -n "lazygit" -c "#{pane_current_path}" lazygit
bind G new-window -n "gh dash" gh dash
bind h new-window -n "htop" htop
bind b new-window -n "btop" btop

# control status bar
bind N set-option status on
bind F set-option status off
bind T set-option status-position top
bind B set-option status-position bottom

bind-key -r u run-shell "tmux neww tmux-sessionizer"
bind-key -r ` run-shell "tmux neww tmux-sessionizer ~"

# skip "kill-pane 1? (y/n)" prompt
bind x kill-pane
bind X kill-session

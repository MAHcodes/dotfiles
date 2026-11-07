set -g @plugin 'aserowy/tmux.nvim'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Source plugins in the background: TPM runs each plugin's .tmux script, and
# those scripts make dozens of tmux CLI calls (one per option/binding), which
# previously blocked server startup for ~0.5s. With -b the config finishes in
# milliseconds and plugins apply a fraction of a second later.
run-shell -b '~/.tmux/plugins/tpm/tpm'

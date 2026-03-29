# neovim
alias n="nvim"
alias kvim="NVIM_APPNAME=kvim command nvim"
alias lvim="NVIM_APPNAME=lvim command nvim"

# misc
alias slmake="rm -rf config.h; sudo make clean install; make clean"
alias nvd="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"
alias ip_wlp0s20f3="ip -brief addr | awk '/wlp0s20f3/{print \$3}'"
alias twtui="taskwarrior-tui"
alias :q="exit"

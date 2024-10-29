# prompt and verbose
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

# better alternatives
alias cat="bat"

# neovim
alias n="nvim"
alias kvim="NVIM_APPNAME=kvim command nvim"

# git
alias gs="git status"
alias gd="git diff"
alias ga="git add"
alias gc="git commit -m"
alias gp="git pull"
alias gP="git push"

# mpv
alias ytmp4="mpv --ytdl --ytdl-format='bestvideo[height=480]+bestaudio' --tls-verify"
alias ytmp3="mpv --ytdl --ytdl-format='bestaudio' --tls-verify --no-video"

# yt-dlp
alias dlpmp3="yt-dlp -f bestaudio -x --audio-format mp3 --embed-thumbnail --add-metadata -o '%(title)s.mp3' --"

# sys
alias uu="sudo apt update && sudo apt upgrade -y"
alias nu="sudo nala upgrade"

# misc
alias slmake="rm -rf config.h; sudo make clean install; make clean"
alias nvd="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"
alias mochify="lutgen apply -p catppuccin-mocha"
alias ip_wlp0s20f3="ip -brief addr | awk '/wlp0s20f3/{print \$3}'"
alias twtui="taskwarrior-tui"

# exit
alias :q="exit"

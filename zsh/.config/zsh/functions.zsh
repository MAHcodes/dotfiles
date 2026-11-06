function mvp () {
	if [[ -e $1 && ! -e $2 ]]; then
	   mkdir --parents --verbose -- "$(dirname -- "$2")"
	fi
	mv --verbose -- "$1" "$2"
}

function fzfrm() {
  if [[ "$#" -eq 0 ]]; then
    local files
    files=$(find . -maxdepth 1 -type f | fzf --multi)
    echo $files | xargs -I '{}' trash-put {} #we use xargs to capture filenames with spaces in them properly
  else
    command trash-put "$@"
  fi
}

# Man without options will use fzf to select a page
function fzfman(){
	MAN="/usr/bin/man"
	if [ -n "$1" ]; then
		$MAN "$@"
		return $?
	else
		$MAN -k . | fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" | awk '{print $1 "." $2}' | tr -d '()' | xargs -r $MAN
		return $?
	fi
}

function fzim(){
  local file=$(find . | fzf --multi --reverse) #get file from fzf
  if [[ $file ]]; then
    for prog in $(echo $file); #open all the selected files
    do; nvim $prog; done;
  fi
}

function fzenv() {
  local out
  out=$(env | fzf)
  echo $(echo $out | cut -d= -f2)
}

function fzkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m --reverse | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# Use lf to switch directories
function lfcd () {
    tmp="$(mktemp)"
    # `command` is needed in case `lfcd` is aliased to `lf`
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# cd into a project using fzf
function fzcdproj() {
  local dir=$(fdprojects | fzf)
  local ret=$?
  cd $dir
  return $ret
}

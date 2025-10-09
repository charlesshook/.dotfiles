function get_system_info() {
    printf "\n"
    printf "  %s\n" "IP Address: $(hostname -I)"
    printf "  %s\n" "USER: $(echo $USER)"
    printf "  %s\n" "DATE: $(date)"
    printf "  %s\n" "UPTIME: $(uptime -p)"
    printf "  %s\n" "HOSTNAME: $(hostname)"
    printf "  %s\n" "KERNEL: $(uname -rms)"
    printf "  %s\n" "RESOLUTION: $(xrandr | awk '/\*/ {print $1}' | head -n 1)"
    printf "  %s\n" "MEMORY: $(free -m -h | awk '/Mem/{print $3"/"$2}')"
    printf "\n"
}

# Colors
green='\[\e[0;32m\]'
reset='\[\e[0m\]'

if [ -e $HOME/.git-prompt.sh ]; then
    source $HOME/.git-prompt.sh
fi

if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi

# History setup
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Update window size
shopt -s checkwinsize

PS1="$green"'→ '"$reset"'\u@\h \W$(__git_ps1 " (%s)"): '

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH="$PATH:/opt/nvim-linux64/bin"

export PATH="$PATH:/usr/local/go/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

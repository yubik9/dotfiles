
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
fi

# gpg-agent
if command -v gpg-agent >/dev/null 2>&1; then
  [ -f ~/.gpg-agent-info ] && source ~/.gpg-agent-info
  if [ -S "$HOME/.gnupg/S.gpg-agent.ssh" ]; then
    export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
  else
    eval $( gpg-agent --daemon )
  fi
fi

# Functions
function git_commit_fancy() {
  git commit -S -m "$*"
}

# Showing current branch

function parse_git_dirty {
  [[ $(git status 2> /dev/null \
  | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null \
  | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}

export PS1='%(?.%F{green}🐶 🐶 🐶 .%F{red}💥 💥 💥 %?)%f%F{green}%(4~|.../%3~|%~) $(parse_git_branch)$%f '
setopt PROMPT_SUBST
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplications
setopt HIST_IGNORE_DUPS
#ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS
setopt CORRECT_ALL
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
#shopt -s cdspell

# Copy SSH Key to Clipboard
function keys() {
  [[ -f ~/.ssh/id_rsa.pub ]] && cat ~/.ssh/id_rsa.pub | pbcopy
  echo "SSH Key copied to clipboard!"
}

alias keys=keys

# Alias
alias ls='ls -G'
alias gc=git_commit_fancy
alias gph='git push'
alias gp='git pull'
alias w='curl -4 wttr.in/sydney'

alias bnc='(bundle check || bundle install --path vendor/bundle)'
alias be='bundle exec'

alias docker_cc='docker ps -a | grep "Exited" | awk "{print $1}" | xargs docker stop | xargs docker rm'
alias docker_ci='docker images | grep "<none>" | awk "{print $3}" | xargs docker rmi'

# system monitoring
alias topcpu='ps aux | sort -n &2 | tail -10'  # top 10 cpu processes
alias topmem='ps aux | sort -n &3 | tail -10'  # top 10 memory processes

# disk usage
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'

# heroku changes
alias hc='git --no-pager log --merges --pretty=format:"%Cred%h%Creset -%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%C(yellow)%d%Creset" --date=short production..master'
alias hdm='git --no-pager diff production master -- db/migrate'

alias lc="git --no-pager log --merges --pretty=format:'%Cred%h%Creset -%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%C(yellow)%d%Creset' --date=short master..develop"
alias ldm="git --no-pager diff master develop -- db/migrate"

# services
alias start_postgres='postgres -D /usr/local/var/postgres'
alias start_redis='redis-server /usr/local/etc/redis.conf'

# rspec
alias pspec='bin/parallel_specs --processes 4'

# kitten
alias ssh='env TERM=xterm-256color ssh' # allows kitty to work with ssh

# jlceda2kicad
function e2k() {
  easyeda2kicad --full --lcsc_id="$*"
}
alias e2k=e2k

# Golang

export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"

export PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin

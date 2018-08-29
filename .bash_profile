
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[ -f ~/.gpg-agent-info ] && source ~/.gpg-agent-info
if [ -S "$HOME/.gnupg/S.gpg-agent.ssh" ]; then
  export SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
else
  eval $( gpg-agent --daemon )
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

export PS1='\[\033[32m\]🐶 🐶 🐶  \w$(parse_git_branch)$\[\033[0m\] '
shopt -s cdspell

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

# dokku
alias dokku='ssh -t dokku@apps.devhub.co'

# Golang

export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

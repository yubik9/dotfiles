
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# Functions
function git_commit_fancy() {
  git commit -m "$*"
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

export PS1='\[\033[37m\]\w$(parse_git_branch)$\[\033[0m\] '
shopt -s cdspell

# Copy SSH Key to Clipboard
function keys() {
  [[ -f ~/.ssh/id_rsa.pub ]] && cat ~/.ssh/id_rsa.pub | pbcopy
  echo "SSH Key copied to clipboard!"
}

alias keys=keys

# Alias

alias gc=git_commit_fancy
alias gph='git push'
alias gp='git pull'

alias e='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias bnc='(bundle check || bundle install --path vendor/bundle)'

# system monitoring
alias topcpu='ps aux | sort -n &2 | tail -10'  # top 10 cpu processes
alias topmem='ps aux | sort -n &3 | tail -10'  # top 10 memory processes

# disk usage
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'

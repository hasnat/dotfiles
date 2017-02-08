source ~/.profile
export PATH="$(brew --prefix php56)/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/Library/Frameworks/Mono.framework/Versions/Current/Commands/:$PATH"
export PATH="$PATH:/usr/local/sbin"
export HISTCONTROL=ignoredups
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=${JAVA_HOME}/bin:$PATH
export ANDROID_HOME=/usr/local/opt/android-sdk
alias ll="ls -lah"

alias composer="php /usr/local/bin/composer"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl" 
alias storm=pstorm
alias xbuild.exe=xbuild

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";
export FIGNORE=$FIGNORE:DS_Store   
export EDITOR='vim'
#Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

#function run
run() {
    number=$1
    shift
    for i in `seq $number`; do
      $@
    done
}

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
#if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
#	complete -o default -o nospace -F _git g;
#fi;

test -f ~/.git-completion.bash && . $_

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;
export PATH=/usr/local/sbin:$PATH

#https://gist.github.com/jlekowski/2194155b7b885f6e2b60
alias ll='ls -alh'
alias git-update='git stash save tmp$(date +"%Y%m%d%H%M"); git pull --rebase; git stash pop; git lg -10'
#alias phpx='XDEBUG_CONFIG="idekey=PHPSTORM" php ' 
alias phpx='PXDEBUG_CONFIG="idekey=PHPSTORM" PHP_IDE_CONFIG="serverName=VagrantXdebug" php -dxdebug.remote_host=10.12.6.92'   
 
function parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
#   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
 
function parse_git_repo() {
    git remote -v 2> /dev/null | sed -e '/push/!d' -e '/origin/!d' -e 's/.*\/\(.*\).git .*/(\1: /'
#   git remote -v 2> /dev/null | sed -e '/push/!d' -e 's/.*\/\(.*\).git .*/(\1: /'
#   git remote -v 2> /dev/null | sed -e '/gitolite\(.*\)push/!d' -e 's/.*:\(.*\) .*/(\1: /'
#   git remote -v 2> /dev/null | sed -e '/push/!d' -e 's/.*git\/\(.*\).git .*/(\1: /'
#   git remote -v 2> /dev/null | sed -e '/push/!d' -e 's/.*git\/\(.*\).git .*/(\1: /' -e 's/.*gitolite.*:\(.*\) .*/(\1: /'
}
 
 
PS1='\[\033[1;31m\][\[\033[1;32m\]\t\[\033[1;31m\]][\[\033[1;33m\]\u\[\033[1;31m\]:\[\033[1;36m\]\W\[\033[1;31m\]]$(parse_git_repo)$(parse_git_branch) \[\033[00m\]$\[\033[00m\] '
#PS1='\[\033[1;31m\][\[\033[1;32m\]\t\[\033[1;31m\]][\[\033[1;33m\]\u\[\033[1;31m\]:\[\033[1;36m\]\W\[\033[1;31m\]]$(git-radar --bash --fetch) \[\033[00m\]$\[\033[00m\] '
#export PS1="$PS1$(git-radar --bash --fetch)"
#PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
### Added gradle
export PATH="$PATH:$HOME/java-tools/gradle-2.6/bin"


# put this in your .bash_profile
if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi

# Piece-by-Piece Explanation:
# the if condition makes sure we only screw with $PROMPT_COMMAND if we're in an iTerm environment
# iTerm happens to give each session a unique $ITERM_SESSION_ID we can use, $ITERM_PROFILE is an option too
# the $PROMPT_COMMAND environment variable is executed every time a command is run
# see: ss64.com/bash/syntax-prompt.html
# we want to update the iTerm tab title to reflect the current directory (not full path, which is too long)
# echo -ne "\033;foo\007" sets the current tab title to "foo"
# see: stackoverflow.com/questions/8823103/how-does-this-script-for-naming-iterm-tabs-work
# the two flags, -n = no trailing newline & -e = interpret backslashed characters, e.g. \033 is ESC, \007 is BEL
# see: ss64.com/bash/echo.html for echo documentation
# we set the title to ${PWD##*/} which is just the current dir, not full path
# see: stackoverflow.com/questions/1371261/get-current-directory-name-without-full-path-in-bash-script
# then we append the rest of $PROMPT_COMMAND so as not to remove what was already there
# voilà!
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#https://github.com/pindexis/marker
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

#!/usr/bin/env bash #adding this to force silly gist highlighting. REMOVE THIS


###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

```alias des='cd ~/Desktop;clear'
alias cls='clear'
alias dow='cd ~/Downloads;clear'
alias doc='cd ~/Documents;clear'
alias www='cd /var/www/html;clear'
alias tmp='cd /tmp;clear'
alias open='xdg-open'
alias grep='grep --color=auto'
alias ll='ls -lah'
alias gitstat='git status'
alias gitlog='git log master'
alias gitdel='git reset --hard'
alias pc='proxychains'
alias bpcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

function cheat {
	pc curl -s cheat.sh/"$1"
}

export PS1='\[\033[01;31m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '```

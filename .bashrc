alias des='cd ~/Desktop;clear'
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
alias ..='cd ../'

export PS1='\[\033[01;31m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

function cheat {
	pc curl -s cheat.sh/"$1"
}

function hgrep {
   grep --color=auto -r "$@" $HISTFILE
}

# Go back to parent dir
# Example: parent .. -> cd ..; parent ...... -> cd ../../../
function parent {
	if [ -z $1 ]; then
		echo "ERROR: empty input"
		return 1
	fi

	num=$(
		sed 's/[^.]//g' <<< "$1" \
			| sed 's/\./&\n/g' \
			| sed '/^$/d' \
			| wc -l
	)

	count=$((num/2))
	cmd="cd "

	for i in $(seq $count); do
		cmd+="../"
	done

	$cmd
}

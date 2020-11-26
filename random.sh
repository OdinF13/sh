#!/bin/bash

arr=()
re='^[0-9]+$'

case $1 in
	'-d')	arr+=({0..9})		;;
	'-c')	arr+=({a..z} {A..Z})	;;
	'-cl')	arr+=({a..z})		;;
	'-cu')	arr+=({A..Z})		;;
	*) arr+=({A..Z} {a..z} {0..9})	;;
esac

function help {
cat <<HELP >&2
USAGE: $0 <TYPE> [LENGTH]

	-d 	Only digits
	-c 	Only characters (upper & lower)
	-cl	Only lowercase characters
	-cu	Only uppercase characters
	*	Upper + Lower + Numbers
HELP
exit 1
}

function random {
	local len=$1

	for i in $(seq $len); do
		echo -ne ${arr[$[RANDOM % ${#arr[@]}]]}
	done

	echo
}

[[ $* =~ "-h" ]] || [[ $* =~ "--help" ]] && help

if [ $# -eq 2 ] && [[ $2 =~ $re ]]; then
	len=$2
elif [ $# -eq 1 ] && [[ $1 =~ $re ]]; then
	len=$1
else
	len=10
fi

random $len

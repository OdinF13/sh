#!/bin/bash

MAN_DIR="/usr/share/man/man1"
MAN_PATH="$MAN_DIR/laravel.1"


if [ ! -d $MAN_DIR ]; then
	echo "Creating $MAN_DIR ..."
	mkdir -p $MAN_DIR
fi

if [ -f $MAN_PATH.gz ]; then
	echo "It seems that you already have manual for laravel"
	echo "To create it again execute following:"
	echo "sudo rm $MAN_PATH.gz"
	exit 1
fi

if [ ! -f /tmp/helpers.php ]; then
	echo "Downloading php file..."
	wget https://raw.githubusercontent.com/laravel/framework/8.x/src/Illuminate/Foundation/helpers.php \
		-U 'Laravel-Enthusiasit' \
		-o /dev/null \
		-P /tmp/
fi

cat <<MAN > $MAN_PATH
.\" Laravel Helpers Manual
.\" Contact odinf13@pm.me to correct errors or typos.
.TH man 8 "05 Oct 2020" "1.0" "Laravel Helpers Manual"
MAN

echo "Creating manual..."
sed -n '/if (\! function_exists/,/^}$/p' /tmp/helpers.php \
	| grep '/\*\*\|function ' -A1 \
	| sed 's/.*\/\*\*//g' \
	| sed 's/.*\* //g' \
	| sed 's/.*function //g' \
	| sed '/.*{/d' \
	| sed '/^--/d' \
	| sed '/^$/d' \
	| sed 'N;s/\(.*\)\n\(.*\)/\n.SH \2\n\1/' >> $MAN_PATH


cat << MAN >> $MAN_PATH

.SH BUGS
No known bugs.
.SH AUTHOR
Odin (Who Loves Bash & PHP)
MAN

echo "Adding manual..."
gzip $MAN_PATH

echo "Done!"
echo "Use: man laravel"

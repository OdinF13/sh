#!/bin/bash

function pastebin {
	if [ $# -ne 1 ]; then
		echo "ERROR: file is required"
		return 1
	elif [ ! -r $1 ]; then
		echo "ERROR: \"$1\" is not readable."
		return 1
	fi

which urlencode &> /dev/null \
	|| {
cat <<SCRIPT > /usr/bin/urlencode
#!/bin/bash
# [C] -> https://gist.github.com/cdown/1163649
old_lc_collate=\$LC_COLLATE
LC_COLLATE=C
length="\${#1}"

for (( i = 0; i < length; i++ )); do
	c="\${1:i:1}"
	case \$c in
		[a-zA-Z0-9.~_-]) printf "\$c" ;;
		*) printf '%%%02X' "'\$c" ;;
	esac
done

LC_COLLATE=\$old_lc_collate
echo
SCRIPT
chmod +x /usr/bin/urlencode
}

pc curl -s 'https://paste.ubuntu.com/' \
	-o /dev/null \
	-w "%{redirect_url}\n" \
	-d 'poster='$(whoami)'&syntax=text&expiration=&content='$(urlencode "$(cat $1)")
}

pastebin $1

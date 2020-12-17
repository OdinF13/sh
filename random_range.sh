function random_range {
	if [ $# -ne 2 ]; then
		echo "Need exactly 2 arguments instead of $#" >&2
		return 1
	fi

	local start=$1
	local end=$2

	if [ $start -ge $end ]; then
		echo "ERROR: end[$end] should be greater than start[$start]" >&2
		return 1
	fi
	
	local diff=$((end-start))
	echo $(( $RANDOM % diff + start))
}

random_range 5 20

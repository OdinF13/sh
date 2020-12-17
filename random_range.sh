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
	local r=$[RANDOM % diff + 1]
	for i in $(seq $r $diff); do
		[ $i -eq $r ] && break
	done
	
	echo $((i+start))
}

random_range 5 20

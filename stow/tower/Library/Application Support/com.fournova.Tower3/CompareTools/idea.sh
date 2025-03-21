#!/bin/zsh

LOCAL="$1"
REMOTE="$2"

# Sanitize LOCAL path
if [[ ! "$LOCAL" =~ ^/ ]]; then
	LOCAL=$(echo "$LOCAL" | sed -e 's/^\.\///')
	LOCAL="$PWD/$LOCAL"
fi

# Sanitize REMOTE path
if [[ ! "$REMOTE" =~ ^/ ]]; then
	REMOTE=$(echo "$REMOTE" | sed -e 's/^\.\///')
	REMOTE="$PWD/$REMOTE"
fi

MERGING="$4"
BACKUP="/tmp/$(date +"%Y%d%m%H%M%S")"

CMD=$(which idea)

if [ ! $CMD ] >/dev/null; then
	if [ -e "$HOME/Library/Application Support/JetBrains/Toolbox/scripts/idea" ]; then
		CMD="$HOME/Library/Application Support/JetBrains/Toolbox/scripts/idea"
	fi
fi

if [ ! -x "$CMD" ]; then
	echo "IntelliJ IDEA command line tool 'idea' could not be found. Please make sure it is installed." >&2
	exit 128
fi

if [ -n "$MERGING" ]; then
	MERGE="$4"

	# Sanitize MERGE path
	if [[ ! "$MERGE" =~ ^/ ]]; then
		MERGE=$(echo "$MERGE" | sed -e 's/^\.\///')
		MERGE="$PWD/$MERGE"

		if [ ! -f "$MERGE" ]; then
			# For conflict "Both Added", Git does not pass the merge param correctly in current versions
			MERGE=$(echo "$LOCAL" | sed -e 's/\.LOCAL\.[0-9]*//')
		fi
	fi

	sleep 1 # required to create different modification timestamp
	touch "$BACKUP"

	"$CMD" --wait "$MERGE"
else
	"$CMD" "$LOCAL" "$REMOTE" 
fi

if [ -n "$MERGING" ]; then
	# Check if the merged file has changed
	if [ "$MERGE" -ot "$BACKUP" ]; then
		exit 1
	fi
fi

exit 0

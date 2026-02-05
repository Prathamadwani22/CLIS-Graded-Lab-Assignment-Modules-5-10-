#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: ./sync.sh <dirA> <dirB>"
    exit 1
fi

dirA="$1"
dirB="$2"

if [ ! -d "$dirA" ] || [ ! -d "$dirB" ]; then
    echo "Error: Both arguments must be valid directories."
    exit 1
fi

echo "Files only in $dirA:"
comm -23 <(ls "$dirA" | sort) <(ls "$dirB" | sort)

echo ""
echo "Files only in $dirB:"
comm -13 <(ls "$dirA" | sort) <(ls "$dirB" | sort)

echo ""
echo "Common files with content comparison:"
for file in $(comm -12 <(ls "$dirA" | sort) <(ls "$dirB" | sort))
do
    if cmp -s "$dirA/$file" "$dirB/$file"; then
        echo "$file : Contents match"
    else
        echo "$file : Contents differ"
    fi
done

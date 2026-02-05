#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: ./patterns.sh <input_file>"
    exit 1
fi

if [ ! -r "$1" ]; then
    echo "Error: Input file not found or not readable."
    exit 1
fi

> vowels.txt
> consonants.txt
> mixed.txt

words=$(tr 'A-Z' 'a-z' < "$1" | tr -c 'a-z\n' '\n')

for word in $words
do
    if echo "$word" | grep -qE '^[aeiou]+$'; then
        echo "$word" >> vowels.txt
    elif echo "$word" | grep -qE '^[bcdfghjklmnpqrstvwxyz]+$'; then
        echo "$word" >> consonants.txt
    elif echo "$word" | grep -qE '^[bcdfghjklmnpqrstvwxyz].*[aeiou].*'; then
        echo "$word" >> mixed.txt
    fi
done

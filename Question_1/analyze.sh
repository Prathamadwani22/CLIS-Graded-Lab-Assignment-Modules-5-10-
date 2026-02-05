#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one argument."
    exit 1
fi

# Check if the given path exists
if [ ! -e "$1" ]; then
    echo "Error: The given path does not exist."
    exit 1
fi

# If argument is a file
if [ -f "$1" ]; then
    lines=$(wc -l < "$1")
    words=$(wc -w < "$1")
    characters=$(wc -c < "$1")

    echo "File Analysis:"
    echo "Lines: $lines"
    echo "Words: $words"
    echo "Characters: $characters"

# If argument is a directory
elif [ -d "$1" ]; then
    total_files=$(find "$1" -type f | wc -l)
    txt_files=$(find "$1" -type f -name "*.txt" | wc -l)

    echo "Directory Analysis:"
    echo "Total files: $total_files"
    echo "Text (.txt) files: $txt_files"

else
    echo "Error: Invalid input."
fi

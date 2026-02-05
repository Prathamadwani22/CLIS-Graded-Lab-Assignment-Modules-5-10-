#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: ./bg_move.sh <directory_path>"
    exit 1
fi

dir="$1"

if [ ! -d "$dir" ]; then
    echo "Error: Directory does not exist."
    exit 1
fi

backup_dir="$dir/backup"
mkdir -p "$backup_dir"

echo "Parent Script PID: $$"

pids=()

for file in "$dir"/*; do
    if [ -f "$file" ]; then
        mv "$file" "$backup_dir/" &
        pid=$!
        echo "Moving $(basename "$file") in background. PID: $pid"
        pids+=("$pid")
    fi
done

for pid in "${pids[@]}"; do
    wait "$pid"
done

echo "All background file move operations completed."

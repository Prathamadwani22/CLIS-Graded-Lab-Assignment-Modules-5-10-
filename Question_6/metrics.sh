#!/bin/bash

if [ ! -r input.txt ]; then
    echo "Error: input.txt file not found or not readable."
    exit 1
fi

words=$(tr 'A-Z' 'a-z' < input.txt | tr -c 'a-z\n' '\n')
clean_words=$(echo "$words" | grep -v '^$')

unique_count=$(echo "$clean_words" | sort | uniq | wc -l)

longest_word=$(echo "$clean_words" | awk '{ if (length > max) { max = length; word = $0 } } END { print word }')
shortest_word=$(echo "$clean_words" | awk 'NR==1 { min = length; word = $0 } { if (length < min) { min = length; word = $0 } } END { print word }')
average_length=$(echo "$clean_words" | awk '{ total += length; count++ } END { if (count>0) print total/count; else print 0 }')

echo "Text File Metrics:"
echo "------------------"
echo "Longest word: $longest_word"
echo "Shortest word: $shortest_word"
echo "Average word length: $average_length"
echo "Total unique words: $unique_count"

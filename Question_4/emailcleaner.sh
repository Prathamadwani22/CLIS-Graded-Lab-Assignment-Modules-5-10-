#!/bin/bash

# Check if emails file exists and is readable
if [ ! -r emails.txt ]; then
    echo "Error: emails.txt file not found or not readable."
    exit 1
fi

# Extract valid email addresses (letters_and_digits@letters.com)
grep -E '^[A-Za-z0-9]+@[A-Za-z]+\.com$' emails.txt \
    | sort | uniq > valid.txt

# Extract invalid email addresses
grep -vE '^[A-Za-z0-9]+@[A-Za-z]+\.com$' emails.txt > invalid.txt

echo "Email cleaning completed."
echo "Valid emails saved in valid.txt"
echo "Invalid emails saved in invalid.txt"

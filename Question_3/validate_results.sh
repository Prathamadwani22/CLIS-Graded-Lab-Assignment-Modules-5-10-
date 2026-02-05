#!/bin/bash

# Check if marks file exists and is readable
if [ ! -r marks.txt ]; then
    echo "Error: marks.txt file not found or not readable."
    exit 1
fi

failed_one=0
passed_all=0

echo "Students who failed in exactly ONE subject:"
echo "------------------------------------------"

while IFS=',' read -r roll name m1 m2 m3
do
    fail_count=0

    if [ "$m1" -lt 33 ]; then
        fail_count=$((fail_count + 1))
    fi
    if [ "$m2" -lt 33 ]; then
        fail_count=$((fail_count + 1))
    fi
    if [ "$m3" -lt 33 ]; then
        fail_count=$((fail_count + 1))
    fi

    if [ "$fail_count" -eq 1 ]; then
        echo "$roll, $name"
        failed_one=$((failed_one + 1))
    fi

    if [ "$fail_count" -eq 0 ]; then
        passed_all=$((passed_all + 1))
    fi

done < marks.txt

echo ""
echo "Students who passed in ALL subjects:"
echo "----------------------------------"

while IFS=',' read -r roll name m1 m2 m3
do
    if [ "$m1" -ge 33 ] && [ "$m2" -ge 33 ] && [ "$m3" -ge 33 ]; then
        echo "$roll, $name"
    fi
done < marks.txt

echo ""
echo "Summary:"
echo "--------"
echo "Students failed in exactly one subject: $failed_one"
echo "Students passed in all subjects: $passed_all"

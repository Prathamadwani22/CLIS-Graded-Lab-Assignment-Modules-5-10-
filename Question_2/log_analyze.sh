#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one log file as an argument."
    exit 1
fi

logfile="$1"

# Check if file exists and is readable
if [ ! -e "$logfile" ]; then
    echo "Error: Log file does not exist."
    exit 1
fi

if [ ! -r "$logfile" ]; then
    echo "Error: Log file is not readable."
    exit 1
fi

# Count total log entries
total_entries=$(wc -l < "$logfile")

# Count log levels
info_count=$(grep -c " INFO " "$logfile")
warning_count=$(grep -c " WARNING " "$logfile")
error_count=$(grep -c " ERROR " "$logfile")

# Get the most recent ERROR message
recent_error=$(grep " ERROR " "$logfile" | tail -n 1)

# Generate report file with current date
report_date=$(date +"%Y-%m-%d")
report_file="logsummary_${report_date}.txt"

{
    echo "Log File Summary Report"
    echo "Date: $report_date"
    echo ""
    echo "Total log entries: $total_entries"
    echo "INFO messages: $info_count"
    echo "WARNING messages: $warning_count"
    echo "ERROR messages: $error_count"
    echo ""
    echo "Most recent ERROR message:"
    echo "$recent_error"
} > "$report_file"

echo "Summary report generated: $report_file"

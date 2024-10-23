#!/bin/bash

# List all files excluding .git files and directories
files=$(find . -type f -not -path '*/\.git/*' | sort)

# Create a report file in the current folder
report="./file_report.txt"
echo "File Index Report" > $report
echo "=================" >> $report

# Index counter
index=1

# Loop through the files and add to the report
for file in $files; do
    filename=$(basename "$file")
    folder=$(dirname "$file")
    echo "$index. $filename >>>>>>>>>>> $folder" >> $report
    index=$((index + 1))
creation_time=$(stat -c %y "$file")
echo "$index. $filename >>>>>>>>>>> $folder >>>>>>>>>>> $creation_time" >> $report
done

# Display the report content
cat $report

echo "Report generated: $report"
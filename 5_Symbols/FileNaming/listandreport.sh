#!/bin/bash

# Parameters
report="./file_report.txt"
exclude_paths=('*/\.git/*' '*/\.vscode/*')

# List all files excluding specified paths
find_command="find . -type f"
for path in "${exclude_paths[@]}"; do
    find_command+=" -not -path '$path'"
done
files=$(eval "$find_command" | sort)

# Create a report file in the current folder
echo "File Index Report" > $report
echo "=================" >> $report

# Index counter
index=1

# Loop through the files and add to the report
for file in $files; do
    filename=$(basename "$file")
    folder=$(dirname "$file")
    prefix=$(echo "$filename" | grep -o '^[0-9]*')
    rest_of_filename=$(echo "$filename" | sed "s/^[0-9]*//")
    echo "$prefix $rest_of_filename >>>>>>>>>>> $folder" >> $report
    index=$((index + 1))
done

# Display the report content
cat $report

echo "Report generated: $report"
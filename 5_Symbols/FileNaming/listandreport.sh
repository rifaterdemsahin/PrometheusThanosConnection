#!/bin/bash

# Parameters
report="./selflearning_report.txt"
creation_date=$(date +"%Y-%m-%d")
exclude_paths=('*/\.git/*' '*/\.vscode/*')

# List all files excluding specified paths
find_command="find . -type f"
for path in "${exclude_paths[@]}"; do
    find_command+=" -not -path '$path'"
done
files=$(eval "$find_command")

# Separate files into those with numeric prefixes and those without
files_with_numbers=$(echo "$files" | grep -E '/[0-9]+[^/]*$' | sort -V)
files_without_numbers=$(echo "$files" | grep -v -E '/[0-9]+[^/]*$')

# Create a report file in the current folder
echo "Self Learning Report" > $report
echo "====================" >> $report

# Index counter
index=1

# Process files with numeric prefixes
for file in $files_with_numbers; do
    filename=$(basename "$file")
    folder=$(dirname "$file")
    prefix=$(echo "$filename" | grep -o '^[0-9]*')
    rest_of_filename=$(echo "$filename" | sed "s/^[0-9]*//")
    echo "$prefix $rest_of_filename >>>>>>>>>>> $folder" >> $report
    index=$((index + 1))
done

# Process files without numeric prefixes
for file in $files_without_numbers; do
    filename=$(basename "$file")
    folder=$(dirname "$file")
    echo "NoPrefix $filename >>>>>>>>>>> $folder" >> $report
    index=$((index + 1))
done

# Display the report content
cat $report

echo "Report generated: $report"
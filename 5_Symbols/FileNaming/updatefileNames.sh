#!/bin/bash
# chmod 777 /workspaces/PrometheusThanosConnection/5_Symbols/Update/updatefileNames.sh
# ./workspaces/PrometheusThanosConnection/5_Symbols/Update/updatefileNames.sh
set -x  # Enable debugging

# Parameters
WORKSPACE_DIR="/workspaces/PrometheusAsDataSource/"
EXCLUDE_DIRS=("./.git/*" "./5_Symbols/*")
COUNTER_FORMAT="%02d"

# List all files in the current directory and subdirectories, excluding the specified directories
cd "$WORKSPACE_DIR"
files=($(find . -type f -not -path "${EXCLUDE_DIRS[0]}" -not -path "${EXCLUDE_DIRS[1]}"))
echo "Files found: ${files[@]}"

# Sort files by creation date
sorted_files=($(ls -t --time=ctime "${files[@]}"))
echo "Sorted files: ${sorted_files[@]}"

# Initialize counter
counter=0

# Function to convert a string to lowercase
to_lowercase() {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}

# Loop through sorted files and rename them
for file in "${sorted_files[@]}"; do
    echo "Processing file: $file"
    # Skip files under the excluded directories
    for exclude_dir in "${EXCLUDE_DIRS[@]}"; do
        if [[ "$file" == $exclude_dir ]]; then
            echo "Skipping excluded file: $file"
            continue 2
        fi
    done
    # Extract the filename without the path
    filename=$(basename "$file")
    echo "Original filename: $filename"
    # Remove numeric parts at the start of the filename
    new_filename=$(echo "$filename" | sed 's/^[0-9]*_//')
    echo "Filename without numeric prefix: $new_filename"
    # Convert the filename to lowercase
    lowercase_filename=$(to_lowercase "$new_filename")
    echo "Lowercase filename: $lowercase_filename"
    # Format the counter with leading zeros
    formatted_counter=$(printf "$COUNTER_FORMAT" $counter)
    echo "Formatted counter: $formatted_counter"
    # Rename the file with the new prefix
    new_file_path="$(dirname "$file")/${formatted_counter}_$lowercase_filename"
    echo "Renaming '$file' to '$new_file_path' with index $counter"
    mv "$file" "$new_file_path"
    # Increment the counter
    ((counter++))
done

set +x  # Disable debugging

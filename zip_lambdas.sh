#!/bin/bash

# Navigate to the lambda directory
cd ./lambda || { echo "Directory 'lambda' not found!"; exit 1; }

# Loop through all Python files
for py_file in *.py; do
    if [ -f "$py_file" ]; then
        # Create a zip file with the same name as the Python file
        zip "${py_file%.py}.zip" "$py_file"
        if [ $? -eq 0 ]; then
            echo "Created zip archive for $py_file"
        else
            echo "Failed to create zip archive for $py_file"
        fi
    fi
done

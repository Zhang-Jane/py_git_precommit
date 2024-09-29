#!/bin/bash

# Get the list of staged files for commit
FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '\.py$')

# Check if there are any Python files to process
if [ -z "$FILES" ]; then
  echo "No Python files to check."
  exit 0
fi

# Example script
echo "Running pre-commit script..."

# Loop through each file and run make pylint_file, flake8_file, and mypy_file
for FILE in $FILES; do
    echo "STEP1: Running make check file syntax=$FILE..."
    make check_syntax_file file="$FILE"
    if [ $? -ne 0 ]; then
        echo "Compileall failed for $FILE. Aborting commit."
        exit 1
    fi

#    echo "STEP1: Running make pylint_file file=$FILE..."
#    make pylint_file file="$FILE"
#    if [ $? -ne 0 ]; then
#        echo "Pylint failed for $FILE. Aborting commit."
#        exit 1
#    fi

#    echo "STEP2: Running make flake8_file file=$FILE..."
#    make flake8_file file="$FILE"
#    if [ $? -ne 0 ]; then
#        echo "Flake8 failed for $FILE. Aborting commit."
#        exit 1
#    fi

#    echo "STEP2: Running make mypy_file file=$FILE..."
#    make mypy_file file="$FILE"
#    if [ $? -ne 0 ]; then
#        echo "Mypy failed for $FILE. Aborting commit."
#        exit 1
#    fi
done

echo "Pre-commit script finished successfully."

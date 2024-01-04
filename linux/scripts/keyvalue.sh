#!/bin/bash

# Check if a file argument is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

filename="$1"

# Read the file line by line
while IFS= read -r line; do
  # Check if the line matches the pattern [key=value]
  if [[ $line =~ \[([^=]+)=([^]]+)\] ]]; then
    # Extract key and value
    key="${BASH_REMATCH[1]}"
    value="${BASH_REMATCH[2]}"

    # Set the variable
    declare "$key=$value"
  fi
done < "$filename"

# Print the variables (for demonstration purposes)
echo "Variables set:"
echo "KEY1=$KEY1"
echo "KEY2=$KEY2"
# Add more variables as needed

# Rest of your script...

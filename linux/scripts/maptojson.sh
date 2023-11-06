#!/bin/bash

# Check if an argument is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <input_string>"
  exit 1
fi

input_string="$1"

# Use sed to wrap double quotes around words, not special characters
quoted_string=$(echo "$input_string" | sed -E 's/([[:alnum:]][[:alnum:]_]*)/"\1"/g')

echo "Original String: $input_string"
echo "String with Double Quotes: $quoted_string"

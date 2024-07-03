# Check if the .terraform-version file exists in the current directory
if [ -f "$source_file" ]; then
    # Copy the .terraform-version file to the destination directory
    cp "$source_file" "$destination_directory"
    echo "Copied $source_file to $destination_directory"
else
    echo "No $source_file found in the current directory."
fi

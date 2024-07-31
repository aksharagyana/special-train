# Define the path to the directory
$directoryPath = "C:\Path\To\Your\Directory"

# Check if the directory exists
if (Test-Path $directoryPath) {
    # Get all files in the directory and subdirectories
    $files = Get-ChildItem -Path $directoryPath -File -Recurse

    # Print each file to the console
    foreach ($file in $files) {
        Write-Host $file.FullName
    }
} else {
    Write-Host "The directory '$directoryPath' does not exist."
}

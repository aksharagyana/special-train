# Define the path to the file
$filePath = "C:\Path\To\Your\File.txt"

# Check if the file exists
if (Test-Path $filePath) {
    # Read the contents of the file line by line
    $fileContents = Get-Content -Path $filePath

    # Print each line to the console
    foreach ($line in $fileContents) {
        Write-Host $line
    }
} else {
    Write-Host "The file '$filePath' does not exist."
}

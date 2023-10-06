# Define the full path to the file you want to create, including its parent directories
$filePath = "C:\MyDirectory\SubDir1\MyFile.txt"

# Define the content you want to write to the file
$fileContent = @"
This is the content of the file.
You can add more text here.
"@

# Create the parent directories if they don't exist
$parentDirectory = [System.IO.Path]::GetDirectoryName($filePath)
if (-not (Test-Path -Path $parentDirectory -PathType Container)) {
    New-Item -Path $parentDirectory -ItemType Directory -Force
}

# Write the content to the file
$fileContent | Set-Content -Path $filePath

Write-Host "File and its parent directories created successfully."

# Specify the path of the directory structure you want to create
$directoryPath = "C:\Path\To\Your\Directory\Structure"

# Check if the directory already exists
if (-not (Test-Path -Path $directoryPath -PathType Container)) {
    # If it doesn't exist, create it
    New-Item -Path $directoryPath -ItemType Directory -Force
    Write-Host "Directory structure created: $directoryPath"
} else {
    Write-Host "Directory structure already exists: $directoryPath"
}

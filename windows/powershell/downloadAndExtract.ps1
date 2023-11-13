# Set the URL of the zip file
$zipUrl = "https://www.example.com/path/to/yourfile.zip"

# Set the path for the download location
$downloadPath = "C:\Path\To\Download"

# Create the download directory if it doesn't exist
if (-not (Test-Path -Path $downloadPath)) {
    New-Item -ItemType Directory -Path $downloadPath | Out-Null
}

# Set the output path for the extracted files
$extractPath = "C:\Path\To\Extract"

# Download the zip file
Invoke-WebRequest -Uri $zipUrl -OutFile "$downloadPath\yourfile.zip"

# Unzip the downloaded file to the extraction path
Expand-Archive -Path "$downloadPath\yourfile.zip" -DestinationPath $extractPath


# Get the folder that starts with "FSLogix_Apps"
$folderName = (Get-ChildItem -Directory -Path "C:\Path\To\ParentFolder" -Filter "FSLogix_Apps*").Name

# Output the folder name
Write-Host "The folder name is: $folderName"

# Specify the drive letter (e.g., C:)
$driveLetter = "C:"

# Specify the output file path
$outputFilePath = "C:\FolderSizes.txt"

# Get all folders in the specified drive
$folders = Get-ChildItem -Path $driveLetter -Directory

# Create an array to store folder details
$outputData = @()

# Iterate through each folder and calculate its size
foreach ($folder in $folders) {
    $folderPath = $folder.FullName
    $folderSizeMB = Get-ChildItem -Path $folderPath -Recurse | Measure-Object -Property Length -Sum | Select-Object @{Name="SizeMB";Expression={$_.Sum / 1MB}}

    # Add folder details to the array
    $outputData += [PSCustomObject]@{
        FolderPath = $folderPath
        SizeMB = $folderSizeMB.SizeMB
    }
}

# Output header to the console
Write-Output "Folder Path`tSize (MB)"

# Output folder details to the console and file
$outputData | ForEach-Object {
    $outputLine = "$($_.FolderPath)`t$($_.SizeMB)"
    Write-Output $outputLine
    Add-Content -Path $outputFilePath -Value $outputLine
}

# Notify user about the completion and the file path
Write-Output "Output written to $outputFilePath"

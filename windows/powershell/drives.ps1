# Get all PS drives
$allDrives = Get-PSDrive

# Display all drives
Write-Host "All Drives:"
$allDrives

# Get only the file system drives
$fileSystemDrives = Get-PSDrive -PSProvider FileSystem

# Display file system drives
Write-Host "`nFile System Drives:"
$fileSystemDrives

# Get detailed volume information
$volumes = Get-Volume

# Display volume information
Write-Host "`nVolume Information:"
$volumes

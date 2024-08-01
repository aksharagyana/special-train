# Function to check for Indirect Display Driver
function Check-IndirectDisplayDriver {
    try {
        # Get all display devices
        $displayDevices = Get-PnpDevice -Class Display

        if ($displayDevices.Count -eq 0) {
            Write-Host "No display devices found." -ForegroundColor Yellow
            return
        }

        $iddFound = $false
        foreach ($device in $displayDevices) {
            # Check if the device name or description contains "Indirect Display"
            if ($device.FriendlyName -like "*Indirect Display*" -or $device.Description -like "*Indirect Display*") {
                Write-Host "Indirect Display Driver found:" -ForegroundColor Green
                Write-Host "Device Name: $($device.FriendlyName)" -ForegroundColor Green
                Write-Host "Device Description: $($device.Description)" -ForegroundColor Green
                $iddFound = $true
                break
            }
        }

        if (-not $iddFound) {
            Write-Host "No Indirect Display Driver found." -ForegroundColor Red
        }

    } catch {
        Write-Host "An error occurred: $_" -ForegroundColor Red
    }
}

# Call the function to check for Indirect Display Driver
Check-IndirectDisplayDriver

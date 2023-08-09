# Define the time zone ID (use the desired time zone ID, e.g., "Pacific Standard Time")
$timeZoneId = "Pacific Standard Time"

# Set the time zone using the Set-TimeZone cmdlet
Set-TimeZone -Id $timeZoneId

# Update the time zone in the registry to persist across restarts
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation"
$regName = "TimeZoneKeyName"
Set-ItemProperty -Path $regPath -Name $regName -Value $timeZoneId

Write-Output "Time zone set to '$timeZoneId' and will persist across restarts."

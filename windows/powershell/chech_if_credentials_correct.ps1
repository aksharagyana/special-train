$targetUsername = "TargetUser"
$targetPassword = "TargetPassword"  # Replace with the actual password
$remoteComputer = "RemoteComputer"   # Replace with an actual remote computer

# Convert the password to a secure string
$securePassword = ConvertTo-SecureString -String $targetPassword -AsPlainText -Force

# Create a PSCredential object
$credential = New-Object System.Management.Automation.PSCredential -ArgumentList $targetUsername, $securePassword

# Define a script block to test the connection (e.g., checking if a file exists)
$scriptBlock = {
    Test-Path -Path "C:\Path\To\SomeFile.txt"
}

# Attempt to run the script block on the remote computer using the provided credentials
try {
    Invoke-Command -ComputerName $remoteComputer -ScriptBlock $scriptBlock -Credential $credential -ErrorAction Stop
    Write-Host "Credentials are correct!"
} catch {
    Write-Host "Credentials are incorrect."
}

# Define the path to the PowerShell script you want to execute on user logon
$scriptPath = "C:\Path\To\Your\Script.ps1"

# Define the path to the source file you want to copy
$sourceFilePath = "C:\Path\To\Your\SourceFile.txt"

# Define the path to the destination folder where you want to copy the file
$destinationFolderPath = "C:\Path\To\Your\DestinationFolder"

# Define the PowerShell command to execute (Copy-Item command)
$powerShellCommand = "Copy-Item -Path `"$sourceFilePath`" -Destination `"$destinationFolderPath`" -Force"

# Define the action to run the PowerShell command
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument $powerShellCommand


# Define the action to run the PowerShell script
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File `"$scriptPath`""

# Define the trigger for any user logon
$trigger = New-ScheduledTaskTrigger -AtLogOn -User "AnyUser" -RandomDelay (New-TimeSpan -Minutes 1)

# Create the scheduled task
Register-ScheduledTask -TaskName "RunScriptOnLogon" -Trigger $trigger -Action $action -RunLevel Highest -Force

Write-Output "Scheduled task created to run the script on user logon for any user."

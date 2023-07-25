# Define the path to the PowerShell script you want to execute on user logon
$scriptPath = "C:\Path\To\Your\Script.ps1"

# Define the action to run the PowerShell script
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File `"$scriptPath`""

# Define the trigger for any user logon
$trigger = New-ScheduledTaskTrigger -AtLogOn -User "AnyUser" -RandomDelay (New-TimeSpan -Minutes 1)

# Create the scheduled task
Register-ScheduledTask -TaskName "RunScriptOnLogon" -Trigger $trigger -Action $action -RunLevel Highest -Force

Write-Output "Scheduled task created to run the script on user logon for any user."

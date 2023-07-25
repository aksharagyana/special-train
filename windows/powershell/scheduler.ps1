# Define the path to the PowerShell script you want to execute on user logon
$scriptPath = "C:\Path\To\Your\Script.ps1"

# Define the action to run the PowerShell script
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File `"$scriptPath`""

# Define the trigger for user logon
$trigger = New-ScheduledTaskTrigger -AtLogOn -User "<UserName>"

# Create the scheduled task
Register-ScheduledTask -TaskName "RunScriptOnLogon" -Trigger $trigger -Action $action -User "<UserName>" -RunLevel Highest -Force

Write-Output "Scheduled task created to run the script on user logon."

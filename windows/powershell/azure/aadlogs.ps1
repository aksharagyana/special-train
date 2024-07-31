# Define the path to the AAD logs
$aadLogPath = "C:\Windows\System32\config\systemprofile\AppData\Local\Packages\Microsoft.AAD.BrokerPlugin_cw5n1h2txyewy\LocalState\Logs"

# Get the list of log files
$logFiles = Get-ChildItem -Path $aadLogPath

# Output the list of log files
$logFiles

# Read a specific log file (for example, the most recent log file)
$latestLogFile = $logFiles | Sort-Object LastWriteTime -Descending | Select-Object -First 1
Get-Content -Path $latestLogFile.FullName

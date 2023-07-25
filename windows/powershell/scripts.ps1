$scriptPath = "C:\Path\To\YourScript.ps1"

# Start the PowerShell script silently and wait for it to finish
Start-Process powershell.exe -ArgumentList "-File `"$scriptPath`"" -NoNewWindow -Wait


# Set Google Chrome as the default browser to all users

$progId = "ChromeHTML"
$urls = "ftp", "http", "https"
$regProperty = "ProgId"

foreach ($url in $urls) {
    $regKey = "HKLM:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\$url\UserChoice"
    Set-ItemProperty -Path $regKey -Name $regProperty -Value "ChromeHTML"

    # Set the same value for the current user
    $regKey = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\$url\UserChoice"
    Set-ItemProperty -Path $regKey -Name $regProperty -Value "ChromeHTML"
}

Write-Host "Google Chrome is now the default browser for all users."

# or Set Google Chrome as the default browser to all users

$regKey = "HKLM:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\{0}\UserChoice"
$regKeyFtp = $regKey -f 'ftp'
$regKeyHttp = $regKey -f 'http'
$regKeyHttps = $regKey -f 'https'

Set-ItemProperty -Path $regKeyFtp -Name ProgId -Value "ChromeHTML"
Set-ItemProperty -Path $regKeyHttp -Name ProgId -Value "ChromeHTML"
Set-ItemProperty -Path $regKeyHttps -Name ProgId -Value "ChromeHTML"

<?xml version="1.0" encoding="UTF-8"?>
<DefaultAssociations>
  <Association Identifier=".htm" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier=".html" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier="http" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier="https" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
</DefaultAssociations>

$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System'
$Name = "DefaultAssociationsConfiguration"
$value = '\\NetworkShare\EDGE\defaultapplication.XML'

New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType String -Force | Out-Null

# Define the source file path (file to be copied)
$sourceFilePath = "C:\Path\To\Your\File.txt"

# Get a list of user profiles on the computer
$userProfiles = Get-WmiObject Win32_UserProfile | Where-Object { $_.Special -eq $false }

# Copy the file to each user's desktop
foreach ($userProfile in $userProfiles) {
    $desktopPath = Join-Path -Path $userProfile.LocalPath -ChildPath "Desktop"
    $destinationFilePath = Join-Path -Path $desktopPath -ChildPath (Split-Path $sourceFilePath -Leaf)
    Copy-Item -Path $sourceFilePath -Destination $destinationFilePath -Force
}

Write-Output "File copied to each user's desktop."


# Define the name of the new Group Policy Object
$gpoName = "MyLoginScriptGPO"

# Define the path to the PowerShell script to run during logon
$scriptPath = "C:\Path\To\Your\ShortcutCreationScript.ps1"

# Create a new Group Policy Object
$gpo = New-GPO -Name $gpoName

# Link the GPO to the desired OU (replace "OU=YourOU,DC=yourdomain,DC=com" with the actual OU path)
$ouPath = "OU=YourOU,DC=yourdomain,DC=com"
New-GPLink -Name $gpoName -Target $ouPath -LinkEnabled Yes

# Define the registry settings to execute the PowerShell script during logon
$regKeyPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Group Policy Objects\$($gpo.Id)\User\Scripts\Logon\0"
$regValueName = "Script"
$regValueType = "String"
$regValueData = $scriptPath

# Set the registry value in the GPO
Set-GPRegistryValue -Name $gpoName -Key $regKeyPath -ValueName $regValueName -Type $regValueType -Value $regValueData

# Optional: Force a Group Policy update on the targeted computers to apply the GPO immediately
# Invoke-GPUpdate -Computer "Computer1", "Computer2" -RandomDelayInMinutes 0

Write-Output "Group Policy '$gpoName' has been applied and will run the script during user logon."


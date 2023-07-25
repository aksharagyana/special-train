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

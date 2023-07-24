$scriptPath = "C:\Path\To\YourScript.ps1"

# Start the PowerShell script silently and wait for it to finish
Start-Process powershell.exe -ArgumentList "-File `"$scriptPath`"" -NoNewWindow -Wait


# Set Google Chrome as the default browser to all users

$progId = "ChromeHTML"
$urls = "ftp", "http", "https"

foreach ($url in $urls) {
    $regKey = "HKLM:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\$url\UserChoice"
    Set-ItemProperty $regKey -name ProgId $progId

    # Set the same value for the current user
    $regKey = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\$url\UserChoice"
    Set-ItemProperty $regKey -name ProgId $progId
}

Write-Host "Google Chrome is now the default browser for all users."

# or Set Google Chrome as the default browser to all users

$regKey = "HKLM:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\{0}\UserChoice"
$regKeyFtp = $regKey -f 'ftp'
$regKeyHttp = $regKey -f 'http'
$regKeyHttps = $regKey -f 'https'

Set-ItemProperty $regKeyFtp -name ProgId ChromeHTML
Set-ItemProperty $regKeyHttp -name ProgId ChromeHTML
Set-ItemProperty $regKeyHttps -name ProgId ChromeHTML

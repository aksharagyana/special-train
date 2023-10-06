# Define the domain name, username, and password
$domainName = "YourDomain.local"
$adminUsername = "Administrator"  # Replace with the domain admin username
$adminPassword = "YourAdminPassword"  # Replace with the domain admin password

# Specify the credentials for joining the domain
$credential = New-Object System.Management.Automation.PSCredential($adminUsername, (ConvertTo-SecureString $adminPassword -AsPlainText -Force))

# Specify the OU path where the computer account should be placed
$ouPath = "OU=Computers,DC=YourDomain,DC=local"  # Replace with the actual OU path
try {
# Define the specific IP address of the domain controller
addTodomain -dcIp "192.168.1.100" "192.168.1.101"
# # Set the DNS settings to use the specific DC's IP address
# Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).InterfaceIndex -ServerAddresses $specificDcIp

# # Join the computer to the domain and specify the OU path
# Add-Computer -DomainName $domainName -Credential $credential -OUPath $ouPath -Restart -Force
}
catch {
   Write-Host "An exception occurred when adding to a domain"
}
finally {
  Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).InterfaceIndex -ResetServerAddresses
}


function addTodomain {
    param (
        [string[]]$dcIps
    )
    foreach ($dcIp in $dcIps) {
    try {
        # Set the DNS settings to use the specific DC's IP address
        Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).InterfaceIndex -ServerAddresses $dcIp
      
        # Join the computer to the domain and specify the OU path
        Add-Computer -DomainName $domainName -Credential $credential -OUPath $ouPath -Restart -Force
      }
      catch {
        Write-Host "An exception occurred for string '$dcIp': $($_.Exception.Message)"
      }
    }
}

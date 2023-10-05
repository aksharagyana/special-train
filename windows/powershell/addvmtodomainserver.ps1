# Define the domain name, username, and password
$domainName = "YourDomain.local"
$adminUsername = "Administrator"  # Replace with the domain admin username
$adminPassword = "YourAdminPassword"  # Replace with the domain admin password

# Specify the credentials for joining the domain
$credential = New-Object System.Management.Automation.PSCredential($adminUsername, (ConvertTo-SecureString $adminPassword -AsPlainText -Force))

# Specify the OU path where the computer account should be placed
$ouPath = "OU=Computers,DC=YourDomain,DC=local"  # Replace with the actual OU path

# Join the computer to the domain and specify the OU path
Add-Computer -DomainName $domainName -Credential $credential -OUPath $ouPath -Restart -Force

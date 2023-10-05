# Define the domain name, username, and password
$domainName = "YourDomain.local"
$adminUsername = "Administrator"  # Replace with the domain admin username
$adminPassword = "YourAdminPassword"  # Replace with the domain admin password

# Specify the credentials for joining the domain
$credential = New-Object System.Management.Automation.PSCredential($adminUsername, (ConvertTo-SecureString $adminPassword -AsPlainText -Force))

# Join the computer to the domain
Add-Computer -DomainName $domainName -Credential $credential -Restart -Force

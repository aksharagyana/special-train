# Provide Azure subscription credentials
# You will be prompted to enter your credentials when you run the script
Connect-AzAccount

# Specify the resource group name
$resourceGroupName = "<YourResourceGroupName>"

# Get the VMs in the specified resource group
$vms = Get-AzVM -ResourceGroupName $resourceGroupName -Status

# Take the first 5 VMs and stop them
foreach ($vm in $vms | Select-Object -First 5) {
    Write-Output "Stopping VM: $($vm.Name)"
    Stop-AzVM -ResourceGroupName $resourceGroupName -Name $vm.Name -Force
}

Write-Output "VMs stopped successfully."

# Set the Azure subscription and storage account details
$subscriptionId = "your_subscription_id"
$resourceGroupName = "your_resource_group_name"
$storageAccountName = "your_storage_account_name"

# Connect to the Azure account
Connect-AzAccount

# Set the current Azure subscription
Set-AzContext -SubscriptionId $subscriptionId

# Retrieve the storage account keys
$keys = Get-AzStorageAccountKey -ResourceGroupName $resourceGroupName -AccountName $storageAccountName

# Display the primary and secondary keys
$primarykey = $keys[0].Value
$secondaryKey = $keys[1].Value

Write-Host "Primary Key: $primarykey"
Write-Host "Secondary Key: $secondaryKey"

# Set the Azure Storage account details
$storageAccountKey = "$primarykey"
$containerName = "your_container_name"

# Create a storage context
$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

# Get the blobs in the specified container
$blobs = Get-AzStorageBlob -Container $containerName -Context $storageContext

# Iterate through the blobs and retrieve the URLs and URIs
$blobUrls = @()
$blobUris = @()

foreach ($blob in $blobs) {
    $blobUrl = $blob.ICloudBlob.Uri.AbsoluteUri
    $blobUri = $blob.ICloudBlob.Uri

    $blobUrls += $blobUrl
    $blobUris += $blobUri
}

# Display the blob URLs
Write-Host "Blob URLs:"
$blobUrls

# Display the blob URIs



# these are for the storage account to be used
$resourceGroup = "bloblisttestrg"
$storageAccountName = "contosobloblisttest"
$containerName = "listtestblobs"

# get a reference to the storage account and the context
$storageAccount = Get-AzStorageAccount `
  -ResourceGroupName $resourceGroup `
  -Name $storageAccountName
$ctx = $storageAccount.Context 

# get a list of all of the blobs in the container 
$listOfBlobs = Get-AzStorageBlob -Container $containerName -Context $ctx 

# zero out our total
$length = 0

# this loops through the list of blobs and retrieves the length for each blob
#   and adds it to the total
$listOfBlobs | ForEach-Object {$length = $length + $_.Length}

# output the blobs and their sizes and the total 
Write-Host "List of Blobs and their size (length)"
Write-Host " " 
$listOfBlobs | select Name, Length
Write-Host " "
Write-Host "Total Length = " $length
Write-Host "Blob URIs:"
$blobUris

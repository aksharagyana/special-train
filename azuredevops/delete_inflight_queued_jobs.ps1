# Define your Azure DevOps organization, project, and personal access token
$organization = "your_organization"
$project = "your_project"
$pat = "your_personal_access_token"

# Base64 encode the PAT
$encodedPat = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(":$($pat)"))

# Define the target queue status (e.g., "inProgress", "completed")
$targetStatus = "inProgress"

# Function to get all jobs with the specified status
function Get-Jobs {
    $uri = "https://dev.azure.com/$organization/$project/_apis/build/builds?statusFilter=$targetStatus&api-version=6.0"
    $response = Invoke-RestMethod -Uri $uri -Method Get -Headers @{Authorization = "Basic $encodedPat"}
    return $response.value
}

# Function to delete a job by ID
function Delete-Job {
    param ($jobId)
    $uri = "https://dev.azure.com/$organization/$project/_apis/build/builds/$jobId?api-version=6.0"
    Invoke-RestMethod -Uri $uri -Method Delete -Headers @{Authorization = "Basic $encodedPat"}
    Write-Output "Deleted job with ID: $jobId"
}

# Get all jobs with the specified status
$jobs = Get-Jobs

# Iterate through the jobs and delete each one
foreach ($job in $jobs) {
    Delete-Job -jobId $job.id
}

Write-Output "All jobs with status '$targetStatus' have been deleted."

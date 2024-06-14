#!/bin/bash

# Set your organization, project, and build ID
organization="YourOrganization"
project="YourProject"
buildId="YourBuildId"

# Get list of queued builds
builds=$(curl -u ":$AZURE_DEVOPS_EXT_PAT" -X GET "https://dev.azure.com/$organization/$project/_apis/build/builds?definitions=$buildId&statusFilter=inProgress,notStarted&api-version=6.0" | jq -r '.value[] | .id')

# Loop through each build and cancel it
for build in $builds
do
  echo "Cancelling build $build..."
  curl -u ":$AZURE_DEVOPS_EXT_PAT" -X PATCH "https://dev.azure.com/$organization/$project/_apis/build/builds/$build?api-version=6.0" -H "Content-Type: application/json" -d '{"status":"Cancelling"}'
done

echo "All queued builds have been cancelled."

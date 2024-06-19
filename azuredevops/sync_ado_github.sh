#!/bin/bash

# Define the repository list and organization details
repos=("repo1" "repo2" "repo3") # Add your repository names here
azure_org="your_azure_org"
azure_project="your_azure_project"
github_org="your_github_org"
azure_pat="your_azure_pat" # Personal Access Token for Azure DevOps
github_pat="your_github_pat" # Personal Access Token for GitHub

# Temporary directories for cloning repositories
azure_dir="./azure_repos"
github_dir="./github_repos"

# Function to clone Azure DevOps repository
clone_azure_repo() {
    repo=$1
    git clone https://$azure_pat@dev.azure.com/$azure_org/$azure_project/_git/$repo $azure_dir/$repo
}

# Function to clone GitHub repository
clone_github_repo() {
    repo=$1
    git clone https://$github_pat@github.com/$github_org/$repo.git $github_dir/$repo
}

# Function to copy files from Azure DevOps repo to GitHub repo
copy_files() {
    repo=$1
    cp -r $azure_dir/$repo/* $github_dir/$repo/
}

# Function to push changes to GitHub repository
push_to_github() {
    repo=$1
    cd $github_dir/$repo
    git add .
    git commit -m "Copy files from Azure DevOps repository $repo"
    git push origin main
    cd -
}

# Create temporary directories
mkdir -p $azure_dir $github_dir

# Loop over each repository
for repo in "${repos[@]}"; do
    echo "Processing repository: $repo"

    # Clone repositories
    echo "Cloning Azure DevOps repository $repo..."
    clone_azure_repo $repo

    echo "Cloning GitHub repository $repo..."
    clone_github_repo $repo

    # Copy files from Azure DevOps repo to GitHub repo
    echo "Copying files from Azure DevOps to GitHub repository $repo..."
    copy_files $repo

    # Push changes to GitHub repository
    echo "Pushing changes to GitHub repository $repo..."
    push_to_github $repo

    echo "Finished processing repository: $repo"
done

# Cleanup temporary directories
rm -rf $azure_dir $github_dir

echo "All repositories have been processed."

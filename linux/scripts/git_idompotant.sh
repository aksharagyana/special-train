# Check if the branch already exists
if git show-ref --verify --quiet refs/heads/"$branch_name"; then
    echo "Branch '$branch_name' already exists. Checking out the branch."
    git checkout "$branch_name"
else
    echo "Branch '$branch_name' does not exist. Creating and checking out the branch."
    git checkout -b "$branch_name"
fi

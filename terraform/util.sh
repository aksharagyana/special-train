function tf-compliance { docker run --rm -v $(pwd):/target -i -t eerkunt/terraform-compliance --features tests/ --planfile plan-out.json "$@"; }
function lz-docs-gen {  docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u) quay.io/terraform-docs/terraform-docs:0.18.0 markdown document /terraform-docs/module --output-file /terraform-docs/README.md --config /terraform-docs/.terraform-docs.yml; }
function mdocs-gen { docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u) quay.io/terraform-docs/terraform-docs:0.18.0 markdown document /terraform-docs --output-file /terraform-docs/README.md --config /terraform-docs/.terraform-docs.yml; }

function lzpush { cleanrepo && to-ado && terraform fmt -recursive && setassafe && git add . && git commit -am "update module" && git push && lzpull; }
function lzpull { git pull && to-git && tget; }

function mpush { cleanrepo && terraform fmt -recursive && setassafe && git add . && git commit -am "update module" && git push && mpull; }
function mpull { git pull && to-git && tget;}
function qtest { cd /code/github/quick_tests && tfenv install && terraform apply -var-file=test.tfvars -auto-approve; }
function tget { tfenv install && terraform get -update; }


function to-git {
      # Assign arguments to variables
      directory="$(pwd)"
      search_pattern="https://dev.azure.com/"
      replacement="https://github.com/"
      search_url=$(printf '%s\n' "$search_pattern" | sed -e 's/[]\/$*.^[]/\\&/g') # Escape special characters
      replacement_url=$(printf '%s\n' "$replacement" | sed -e 's/[\/&]/\\&/g') # Escape special characters

      # Find all files in the directory and perform the search and replace
      find "$directory" -type f -exec sed -i "s/$search_url/$replacement_url/g" {} +
      echo "Search and replace complete."
}

function to-ado {
      # Assign arguments to variables
      directory="$(pwd)/module"
      search_pattern="https://github.com/"
      replacement="https://dev.azure.com/"

      search_url=$(printf '%s\n' "$search_pattern" | sed -e 's/[]\/$*.^[]/\\&/g') # Escape special characters
      replacement_url=$(printf '%s\n' "$replacement" | sed -e 's/[\/&]/\\&/g') # Escape special characters

      # Find all files in the directory and perform the search and replace
      find "$directory" -type f -exec sed -i "s/$search_url/$replacement_url/g" {} +
      echo "Search and replace complete."
}

function plan {
 rm -rf "../plan-out.json" "../output.tfplan"
 az account list -o table
 # Get the full path of the current directory
 current_directory=$(pwd)
 # Get the parent directory's path
 parent_directory_path="${current_directory%/*}"
 # Get the name of the parent directory
 parent_directory_name="${parent_directory_path##*/}"
 resource_group_name = ""
 storage_account_name = ""
 container_name = ""
 
 terraform init -upgrade -reconfigure -backend-config="resource_group_name=${resource_group_name}" \
  -backend-config="storage_account_name=${storage_account_name}" \
  -backend-config="container_name=${container_name}" \
  -backend-config="key=${parent_directory_name}.tfstate"
# terraform -or-create workspace select dev
 terraform fmt -recursive
 terraform validate
 terraform plan -var-file="../vars/preprod.tfvars" -out="../output.tfplan"
 terraform show -no-color -json "../output.tfplan" > "../plan-out.json"
 rm -rf "../output.tfplan"
}

function cleanrepo {
  directory="$(pwd)"
  rm -rf "${directory}/plan-out.json"
}

function setassafe {
    git config --global --add safe.directory $(pwd)
}

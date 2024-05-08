locals {
  extra_policy_assignments =merge(flatten([
    for item in var.management_group :[
      for pa in item.extra_policy_assignments : {
        replace(lower(item.name), " ", "") = flatten(formatlist(replace("${path.cwd}/lib/${lower(pa)}/%s", " ", ""), tolist(fileset(replace("${path.module}/lib/${lower(pa)}", " ", ""), "**/policy_assignment_*.{json,json.tftpl}"))))
      }
    ]
  ])...)

  custom_policy_assignments = {
    for item in var.management_group :
    replace(lower(item.name), " ", "") =>
    flatten(formatlist(replace("${path.cwd}/lib/${lower(item.name)}/%s", " ", ""), tolist(fileset(replace("${path.module}/lib/${lower(item.name)}", " ", ""), "**/policy_assignment_*.{json,json.tftpl}"))))
  }
}



locals {
  merged_policy_assignments = {
      for item in var.management_group :
      replace(lower(item.name), " ", "") =>
        concat(lookup(local.custom_policy_assignments, replace(lower(item.name), " ", ""), []), lookup(local.extra_policy_assignments, replace(lower(item.name), " ", ""), []))
    }

}


output "custom_policy_assignments" {
  value = local.custom_policy_assignments
}

output "remove_space" {
  value = replace("var tag    application", " ", "")
}

output "extra_policy_assignments" {
  value= local.extra_policy_assignments
}



output "merged_policy_assignments" {
  value= local.merged_policy_assignments
}



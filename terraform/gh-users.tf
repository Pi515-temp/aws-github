variable "users" {
  type = map(list(string))
  default = {
    Pi515-IA      = ["admin", "Admin", "maintainer"]
    ryanemcdaniel = ["admin", "Admin", "maintainer"]
  }
}

data "github_user" "users" {
  for_each = var.users
  username = each.key
}

locals {
  main_force_push_bypassers = [
    data.github_user.users["ryanemcdaniel"].node_id
  ]
  main_dismissal_restrictions = [
    "/${data.github_user.users["ryanemcdaniel"].username}"
  ]
  main_pull_request_bypassers = [
    "/${data.github_user.users["ryanemcdaniel"].username}"
  ]
}

resource "github_membership" "users" {
  for_each             = element(data.github_user.users[*], 0)
  username             = each.value.username
  role                 = element(var.users[each.key], 0)
}

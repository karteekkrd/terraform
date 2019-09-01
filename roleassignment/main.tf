provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "1.28.0"
  }
#data "azurerm_subscription" "primary" {}

data "azuread_group" "group" {
  name  = "${var.group_name}"
}

resource "azurerm_role_assignment" "role" {
  scope              = "${var.subscription_id}"
  role_definition_name = "${var.role_name}"
  principal_id       = "${data.azuread_group.group.id}"
}

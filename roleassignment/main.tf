provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "1.28.0"
  }
data "azurerm_subscription" "primary" {}

data "azuread_group" "devops" {
  name  = "ENT_DEVOPS_CLOUD_ADMIN"
}

data "azuread_group" "network" {
  name  = "ENT_Azure_Network_Admins"
}

data "azuread_group" "reader" {
  name  = "Azure Subscription Reviewer"
}

resource "azurerm_role_assignment" "admin" {
  scope              = "${data.azurerm_subscription.primary.id}"
  role_definition_name = "Owner"
  principal_id       = "${data.azuread_group.devops.id}"
}


resource "azurerm_role_assignment" "networkcontributer" {
  scope              = "${data.azurerm_subscription.primary.id}"
  role_definition_name = "Network Contributor"
  principal_id       = "${data.azuread_group.network.id}"
}

resource "azurerm_role_assignment" "readaccess" {
  scope              = "${data.azurerm_subscription.primary.id}"
  role_definition_name = "Reader"
  principal_id       = "${data.azuread_group.reader.id}"
}
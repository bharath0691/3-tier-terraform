# # Configure the Microsoft Azure Provider
# provider "azurerm" {
#     subscription_id = var.subscription_id
#     client_id       = var.client_id
#     client_secret   = var.client_secret
#     tenant_id       = var.tenant_id
# }

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.46.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  # subscription_id = var.subscription_id
  # client_id       = var.client_id
  # client_secret   = var.client_secret
  # tenant_id       = var.tenant_id
}

data "azuread_client_config" "current" {}
data "azurerm_client_config" "current" {}

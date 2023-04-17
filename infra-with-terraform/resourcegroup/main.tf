# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "tfrg" {
    name     = var.rg_name
    location = var.location
}

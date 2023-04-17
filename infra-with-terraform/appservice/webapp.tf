resource "azurerm_service_plan" "tfrg" {
  name                = "${var.prefix}-svcplan"
  resource_group_name = var.rg_name
  location            = var.location
  sku_name            = "P1v2"
  os_type             = "Windows"

  
}

resource "azurerm_windows_web_app" "tfrg" {
  name                = "${var.prefix}-appserviceiqsa01"
  resource_group_name = var.rg_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.tfrg.id

  site_config {}
  connection_string {
    name  = "MyDbConnection"
    type  = "SQLServer"
    value = var.MyDbConnectionstring
  }
}

resource "azurerm_sql_server" "tfrg" {
    name                         = "${var.prefix}sqlserveriqsa01"
    resource_group_name          = var.rg_name
    location                     = var.location
    version                      = "12.0"
    administrator_login          = var.admin_username
    administrator_login_password = var.administrator_login_password
}

resource "azurerm_sql_database" "tfrg" {
    name                = "${var.prefix}sqldb"
    resource_group_name = var.rg_name
    location            = var.location
    server_name         = azurerm_sql_server.tfrg.name

    edition             = "Basic"
}

resource "azurerm_sql_firewall_rule" "app_server_firewall_rule_Client_IP" {
  name                = "${var.prefix}-clientipfir"
  resource_group_name = var.rg_name
  server_name         = azurerm_sql_server.tfrg.name
  start_ip_address    = "115.98.98.178"
  end_ip_address      = "115.98.98.178"
#   depends_on=[
#     azurerm_sql_server.sql-server
#   ]
}

resource "azurerm_sql_firewall_rule" "app_server_firewall_rule_Azure_services" {
  name                = "${var.prefix}-appservicefir"
  resource_group_name = var.rg_name
  server_name         = azurerm_sql_server.tfrg.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
#   depends_on=[
#     azurerm_sql_server.sql-server
#   ]
}

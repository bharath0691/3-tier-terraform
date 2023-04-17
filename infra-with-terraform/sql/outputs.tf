output "fqdn" {
    value = azurerm_sql_server.tfrg.fully_qualified_domain_name
}

output "name" {
    value = azurerm_sql_server.tfrg.name
}

output "db_name" {
    value = azurerm_sql_database.tfrg.name
}
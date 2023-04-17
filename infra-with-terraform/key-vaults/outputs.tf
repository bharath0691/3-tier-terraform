output "kv-name" {
    value = azurerm_key_vault.tfrg.name
}

output "password" {
  value = random_password.database_password.result
}

output "secret_name" {
  value = azurerm_key_vault_secret.secret_password.name
}

output "secret_password" {
  value = azurerm_key_vault_secret.secret_password.value
}
data "azurerm_resource_group" "tfrg" {
 name = var.rg_name

}
data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

resource "azurerm_key_vault" "tfrg" {
  name                        = "${var.prefix}-keyvaultsiqsa"
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  // soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
   access_policy {
     tenant_id = data.azurerm_client_config.current.tenant_id
     object_id = data.azuread_client_config.current.object_id

    //  key_permissions = [
    //    "Get","Set",
    //  ]

     secret_permissions = [
       "Get","Set","List","Backup","Delete","Purge","Recover","Restore",
     ]

     storage_permissions = [
       "Get","Set",
     ]
   }
 }

// resource "azurerm_key_vault_access_policy" "tfrg" {
    
//     key_vault_id = azurerm_key_vault.tfrg.id
//     tenant_id = "${data.azurerm_client_config.current.tenant_id}"
//     object_id = "${data.azuread_client_config.current.object_id}"
//     key_permissions = [
//       "Get","Set","List",
//     ]
//     secret_permissions = [
//         "Set","Backup","Delete","List","Purge","Recover","Restore","Get",
//     ] 
//     storage_permissions = [
//     "Get",
//     ]
//     certificate_permissions       = ["Get", "Import", "List"]
//  #   depends_on = [ azurerm_key_vault.app_vault ]
// }



resource "random_password" "database_password" {
  length           = 12
  special          = false
  override_special = "!#@"
  min_lower        = 3
  min_upper        = 3
  min_numeric      = 3

}


resource "azurerm_key_vault_secret" "secret_password" {
  name         = var.secret_name
  value        = random_password.database_password.result
  key_vault_id = azurerm_key_vault.tfrg.id
}
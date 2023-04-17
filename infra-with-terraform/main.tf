module "rg" {
  source   = "./resourcegroup"
  rg_name  = var.rg_name
  location = var.location
}

module "key-vaults" {
  depends_on     = [module.rg]
  source         = "./key-vaults"
  prefix         = var.prefix
  rg_name        = var.rg_name
#  secret_name     = var.admin_username
  location       = var.location
  secret_name    = var.secret_name
}

module "network" {
  depends_on       = [module.rg]
  source           = "./network"
  vnet_name        = var.vnet_name
  rg_name          = var.rg_name
  location         = var.location
  address_space    = var.address_space
  subnet_name      = var.subnet_name
  address_prefixes = var.address_prefixes
}

module "sql" {
  depends_on     = [module.rg]
  source         = "./sql"
  prefix         = var.prefix
  rg_name        = var.rg_name
  admin_username = var.admin_username
  location       = var.location
  administrator_login_password= module.key-vaults.secret_password
}

module "appservice" {
  depends_on                  = [module.rg, module.sql]
  source                      = "./appservice"
  prefix                      = var.prefix
  rg_name                     = var.rg_name
  location                    = var.location
#  MyDbConnectionstring="Server=tcp:${var.prefix}sqlserveriqsa01.database.windows.net,1433;Initial Catalog=${var.prefix}sqldb;Persist Security Info=False;User ID=${var.admin_username};Password=${module.key-vaults.secret_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  MyDbConnectionstring="Server=tcp:${var.prefix}sqlserveriqsa01.database.windows.net,1433;Initial Catalog=${var.prefix}sqldb;Persist Security Info=False;User ID=${var.admin_username};Password=${module.key-vaults.secret_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}

module "appgateway" {
  depends_on                     = [module.rg, module.network]
  source                         = "./appgateway"
  rg_name                        = var.rg_name
  location                       = var.location
  public_ip_name                 = var.public_ip_name
  subnet_id                      = module.network.subnet_id
  appgateway_name                = var.appgateway_name
  sku_name                       = var.sku_name
  sku_tier                       = var.sku_tier
  sku_capacity                   = var.sku_capacity
  gateway_ip_configuration_name  = var.gateway_ip_configuration_name
  frontend_port_name             = var.frontend_port_name
  frontend_ip_configuration_name = var.frontend_ip_configuration_name
  backend_address_pool_name      = var.backend_address_pool_name
  backend_http_settings_name     = var.backend_http_settings_name
  listener_name                  = var.listener_name
  request_routing_rule_name      = var.request_routing_rule_name
  default_site_name = [module.appservice.default_site_name]

}


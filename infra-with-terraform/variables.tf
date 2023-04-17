#azure service principal info
#variable "subscription_id" {}

# client_id or app_id
# variable "client_id" {}

# variable "client_secret" {}


# tenant_id or directory_id
# variable "tenant_id" {}

variable "rg_name" {}

# service variables
variable "prefix" {}

variable "location" {}

# admin username & password for MS SQL
variable "admin_username" {}

#variable "admin_password" {}
variable "vnet_name" {}
variable "address_space" {}
variable "subnet_name" {}
variable "address_prefixes" {}
//variable "fully_qualified_domain_name" {}
//variable "sql_name" {}
variable "appgateway_name" {}
variable "sku_name" {}
variable "sku_tier" {}
variable "sku_capacity" {}
variable "gateway_ip_configuration_name" {}
//variable "subnet_id" {}
variable "frontend_port_name" {}
variable "frontend_ip_configuration_name" {}
variable "backend_address_pool_name" {}
variable "backend_http_settings_name" {}
variable "listener_name" {}
variable "request_routing_rule_name" {}
variable "public_ip_name" {}
variable "secret_name" {}
#variable "administrator_login_password" {}

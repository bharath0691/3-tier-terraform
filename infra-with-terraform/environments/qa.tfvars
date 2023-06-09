rg_name = "qa-rg"
location = "east us"
prefix = "qa"
admin_username = "azureadmin"
admin_password = "Admin@123456"
vnet_name   = "qa-vnet"
address_space = ["10.254.0.0/16"]
subnet_name = "frondend-subnet"
address_prefixes = ["10.254.0.0/24"]
public_ip_name = "qa-pip"
appgateway_name = "qa-appgateway"
sku_name = "Standard_Small"
sku_tier = "Standard"
sku_capacity = "2"
gateway_ip_configuration_name = "qa-gateway-ip-configuration"
frontend_port_name = "qa-frontend-port"
frontend_ip_configuration_name = "qa-frontend-ip-configuration"
backend_address_pool_name = "qa-backend-address-pool"
backend_http_settings_name = "qa-backend-http-setting"
listener_name = "qa-listener-name"
request_routing_rule_name = "qa-request-riuting-rule"
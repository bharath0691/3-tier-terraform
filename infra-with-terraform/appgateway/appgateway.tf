resource "azurerm_public_ip" "ip" {
  name                = var.public_ip_name 
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Dynamic"
}

##################################################################
# Application Gateway
##################################################################
resource "azurerm_application_gateway" "network" {
  name                = var.appgateway_name 
  resource_group_name = var.rg_name
  location            = var.location

  sku {
    name     = var.sku_name 
    tier     = var.sku_tier 
    capacity = var.sku_capacity 
  }

  gateway_ip_configuration {
    name      = var.gateway_ip_configuration_name
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = var.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.ip.id
  }

  backend_address_pool {
    name = var.backend_address_pool_name
    fqdns = var.default_site_name
  }

  backend_http_settings {
    name                  = var.backend_http_settings_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
    pick_host_name_from_backend_address = true
    probe_name  = "healthprobe"
  }

  http_listener {
    name                           = var.listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = "Http"
  }

  probe {
    name = "healthprobe"
    interval = 30
    protocol = "Http"
    path = "/"
    timeout = 30
    unhealthy_threshold = 3
    pick_host_name_from_backend_http_settings = true

    match {
      status_code = [200, 399]
    }
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = var.listener_name
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.backend_http_settings_name
  }
}


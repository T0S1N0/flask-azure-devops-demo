provider "azurerm" {
  features {}
}

variable "location" {
  default = "East US"
}

resource "azurerm_resource_group" "rg" {
  name     = "flask-terraform-rg"
  location = "East US"
}

resource "azurerm_service_plan" "asp" {
  name                = "flask-terraform-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "F1"
  os_type             = "Linux"
}

resource "azurerm_linux_web_app" "app" {
  name                = "flask-terraform-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {}
}

output "app_service_default_site_hostname" {
  value = azurerm_linux_web_app.app.default_site_hostname
}
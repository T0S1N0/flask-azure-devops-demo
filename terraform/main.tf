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

resource "azurerm_app_service_plan" "asp" {
  name                = "flask-terraform-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "flask-terraform-app"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  site_config {
    python_version = "3.10"
  }
}

output "app_service_default_site_hostname" {
  value = azurerm_app_service.app.default_site_hostname
}
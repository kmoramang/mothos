resource "azurerm_resource_group" "azurerm_resource_group_2" {
  tags     = merge(var.tags, {})
  name     = "test1_rg"
  location = var.location
}

resource "azurerm_windows_web_app" "azurerm_windows_web_app_3" {
  tags                = merge(var.tags, {})
  service_plan_id     = azurerm_service_plan.azurerm_service_plan_4.id
  resource_group_name = azurerm_resource_group.azurerm_resource_group_2.name
  name                = "default"
  location            = var.location

  site_config {
    always_on = false
  }
}

resource "azurerm_service_plan" "azurerm_service_plan_4" {
  tags                = merge(var.tags, {})
  sku_name            = "P1v2"
  resource_group_name = azurerm_resource_group.azurerm_resource_group_2.name
  os_type             = "Linux"
  name                = "test1_serviceplan"
  location            = var.location
}


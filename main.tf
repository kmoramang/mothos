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

resource "azurerm_virtual_machine" "azurerm_virtual_machine_5_VM" {
  vm_size             = "Standard_DS1_v2"
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.azurerm_resource_group_2
  name                = "webbappvm"
  location            = var.location

  network_interface_ids = [
    azurerm_network_interface.azurerm_network_interface_6.id,
  ]

  storage_os_disk {
    name              = "myosdisk1"
    managed_disk_type = "Standard_LRS"
    create_option     = "FromImage"
    caching           = "ReadWrite"
  }
}

resource "azurerm_network_interface" "azurerm_network_interface_6" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.azurerm_resource_group_2.name
  name                = "webappvm-nic"
  location            = var.location

  ip_configuration {
    subnet_id                     = azurerm_subnet.azurerm_subnet_8.id
    public_ip_address_id          = azurerm_public_ip.azurerm_public_ip_9.id
    private_ip_address_allocation = "Dynamic"
    name                          = "internal"
  }
}

resource "azurerm_virtual_network" "azurerm_virtual_network_7" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.azurerm_resource_group_2.name
  name                = "webApp-network"
  location            = var.location

  address_space = [
    "10.0.0.0/16",
  ]
}

resource "azurerm_subnet" "azurerm_subnet_8" {
  virtual_network_name = azurerm_virtual_network.azurerm_virtual_network_7.name
  resource_group_name  = azurerm_resource_group.azurerm_resource_group_2.name
  name                 = "internal"

  address_prefixes = [
    "10.0.2.0/24",
  ]
}

resource "azurerm_public_ip" "azurerm_public_ip_9" {
  tags                = merge(var.tags, {})
  resource_group_name = azurerm_resource_group.azurerm_resource_group_2.name
  name                = "WebAppPublicIp1"
  location            = var.location
  allocation_method   = "Static"
}


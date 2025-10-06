# Control Plane NSG
resource "azurerm_network_security_group" "control_plane" {
  name                = var.control_plane_nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_network_security_rule" "control_plane_rules" {
  for_each = { for idx, rule in var.control_plane_ingress_ports : idx => rule }

  name                        = "control-plane-${each.key}"
  priority                    = 100 + each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = each.value.protocol
  source_port_range            = "*"
  destination_port_range       = "${each.value.from_port}-${each.value.to_port}"
  source_address_prefix        = "*"
  destination_address_prefix   = "*"
  network_security_group_name  = azurerm_network_security_group.control_plane.name
  resource_group_name          = azurerm_resource_group.main.name
}

# Worker Node NSG
resource "azurerm_network_security_group" "worker_node" {
  name                = var.worker_node_nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_network_security_rule" "worker_node_rules" {
  for_each = { for idx, rule in var.worker_node_ingress_ports : idx => rule }

  name                        = "worker-node-${each.key}"
  priority                    = 100 + each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = each.value.protocol
  source_port_range            = "*"
  destination_port_range       = "${each.value.from_port}-${each.value.to_port}"
  source_address_prefix        = "*"
  destination_address_prefix   = "*"
  network_security_group_name  = azurerm_network_security_group.worker_node.name
  resource_group_name          = azurerm_resource_group.main.name
}

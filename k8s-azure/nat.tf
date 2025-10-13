# Public IP for NAT Gateway (this is what Azure will use for outbound)
resource "azurerm_public_ip" "nat_pip" {
  name                = "nat-gateway-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
# NAT Gateway
resource "azurerm_nat_gateway" "main" {
  name                    = "nat-gateway"
  location                = var.location
  resource_group_name     = azurerm_resource_group.main.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4
}
# NAT Gateway public ip Association
resource "azurerm_nat_gateway_public_ip_association" "nat_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.main.id
  public_ip_address_id = azurerm_public_ip.nat_pip.id
}
# Associate NAT Gateway to all private subnets
resource "azurerm_subnet_nat_gateway_association" "private" {
  count          = length(azurerm_subnet.private)
  subnet_id      = azurerm_subnet.private[count.index].id
  nat_gateway_id = azurerm_nat_gateway.main.id
}

# Public Master VM with Static Public IP
resource "azurerm_public_ip" "master" {
  name                = "${var.master_vm_name}-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "master" {
  name                = "${var.master_vm_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.master.id
  }
}

resource "azurerm_network_interface_security_group_association" "master" {
  network_interface_id      = azurerm_network_interface.master.id
  network_security_group_id = azurerm_network_security_group.control_plane.id
}

resource "azurerm_linux_virtual_machine" "master" {
  name                  = var.master_vm_name
  resource_group_name   = azurerm_resource_group.main.name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.master.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    disk_size_gb        = "30"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = var.vm_image.publisher
    offer     = var.vm_image.offer
    sku       = var.vm_image.sku
    version   = var.vm_image.version
  }
}

# Two private subnets: azurerm_subnet.private[0] and azurerm_subnet.private[1]
# 3 VMs 2 in 1 private subnet 1 in second → total 4 VMs
resource "azurerm_network_interface" "private" {
  count               = 1
  name                = "private-vm-${count.index + 1}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  ip_configuration {
    name                          = "internal"
    # Map first 2 NICs to first subnet, next 2 NICs to second subnet
    subnet_id                     = azurerm_subnet.private[count.index < 2 ? 0 : 1].id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface_security_group_association" "private" {
  count                     = 1
  network_interface_id      = azurerm_network_interface.private[count.index].id
  network_security_group_id = azurerm_network_security_group.worker_node.id
}

resource "azurerm_linux_virtual_machine" "private" {
  count                 = 1
  name                  = "private-vm-${count.index + 1}"
  resource_group_name   = azurerm_resource_group.main.name
  location              = var.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.private[count.index].id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.vm_image.publisher
    offer     = var.vm_image.offer
    sku       = var.vm_image.sku
    version   = var.vm_image.version
  }
}

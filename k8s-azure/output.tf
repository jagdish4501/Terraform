output "master_vm_public_ip" {
  value = azurerm_public_ip.master.ip_address
}

output "master_vm_private_ip" {
  value = azurerm_network_interface.master.ip_configuration[0].private_ip_address
}

output "private_vm_private_ips" {
  value = azurerm_network_interface.private[*].private_ip_address
}

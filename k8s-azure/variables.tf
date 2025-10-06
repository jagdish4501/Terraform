# vnet related variable
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR for Virtual Network"
  type        = list(string)
}

variable "public_subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR for Subnet"
  type        = string
}

variable "private_subnet_names" {
  description = "List of private subnet names"
  type        = list(string)
}
variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}


# NSG related variable

variable "control_plane_nsg_name" {
  default = "control-plane-nsg"
}

variable "worker_node_nsg_name" {
  default = "worker-node-nsg"
}

variable "control_plane_ingress_ports" {
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
}

variable "worker_node_ingress_ports" {
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
}



# vm related variable
variable "master_vm_name" {
  description = "Virtual Machine name"
  type        = string
}

variable "vm_name" {
  description = "Virtual Machine name"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
}

variable "admin_username" {
  description = "Admin username for VM"
  type        = string
}

variable "public_key" {
  description = "SSH Public Key"
  type        = string
}


# vnet related variable
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "kubernetes-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
  default     = "kubernetes-vnet"
}

variable "vnet_cidr" {
  description = "CIDR for Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "public_subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "public-subnet"
}

variable "public_subnet_cidr" {
  description = "CIDR for Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_names" {
  description = "List of private subnet names"
  type        = list(string)
  default     = ["private-subnet-1", "private-subnet-2"]
}
variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}


# NSG related variable

variable "control_plane_nsg_name" {
  type    = string
  default = "control-plane-nsg"
}

variable "worker_node_nsg_name" {
  type    = string
  default = "worker-node-nsg"
}

variable "control_plane_ingress_ports" {
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
  default = [
    { from_port = 22, to_port = 22, protocol = "Tcp" },     # SSH
    { from_port = 6443, to_port = 6443, protocol = "Tcp" }, # K8s API
    { from_port = 2379, to_port = 2380, protocol = "Tcp" }, # etcd
    { from_port = 10250, to_port = 10250, protocol = "Tcp" },
    { from_port = 10259, to_port = 10259, protocol = "Tcp" },
    { from_port = 10257, to_port = 10257, protocol = "Tcp" }
  ]
}

variable "worker_node_ingress_ports" {
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
  default = [
    { from_port = 22, to_port = 22, protocol = "Tcp" },
    { from_port = 10250, to_port = 10250, protocol = "Tcp" },
    { from_port = 30000, to_port = 32767, protocol = "Tcp" }, # NodePort
    { from_port = 30000, to_port = 32767, protocol = "Udp" }  # NodePort UDP
  ]
}



# vm related variable
variable "master_vm_name" {
  description = "Virtual Machine name"
  type        = string
  default     = "kubernetes-master"
}

variable "vm_name" {
  description = "Virtual Machine name"
  type        = string
  default     = "kubernetes-worker"
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for VM"
  type        = string
  default     = "jagdish"
}

variable "public_key" {
  description = "SSH Public Key"
  type        = string
}

variable "vm_image" {
  description = "VM image reference for all VMs"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}

variable "ami" {
  description="amazone machine instace id"
  type = string
}
variable "instance_type" {
  description = "instace type t2-micro t3-large etc"
  type        = string
}
variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in."
  type        = string
}
variable "security_group_ids" {
  description = "A list of security group IDs to associate with the instance."
  type        = list(string)
}
variable "associate_public_ip" {
  description = "Whether to associate a public IP address with the instance."
  type        = bool
  default     = false
}
variable "key_name" {
  description = "The name of the key pair to use for the instance."
  type        = string
}
variable "user_data" {
  description = "The user data to provide when launching the instance."
  type        = string
  default     = null
}
variable "monitoring" {
  description = "Enable detailed monitoring for the instance."
  type        = bool
  default     = true
}
variable "disable_api_termination" {
  description = "Enable termination protection for the instance."
  type        = bool
  default     = false
}
variable "assign_elastic_ip" {
  description = "Whether to assign an Elastic IP to the instance."
  type        = bool
  default     = false
}

variable "tags" {
  type = map(string)
}
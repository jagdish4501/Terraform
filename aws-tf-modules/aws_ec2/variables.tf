variable "ami" {

}
variable "instance_type" {

}
variable "subnet_id" {
  
}
variable "security_group_ids" {
  type = list(string)
}
variable "associate_public_ip" {
  default = false
}
variable "tags" {
  type = map(string)
}
variable "key_name" {
  type    = string
  default = ""
}

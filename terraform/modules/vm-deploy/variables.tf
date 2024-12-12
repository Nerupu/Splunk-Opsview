variable "instance_type" {
  type = string
}

variable "name" {
  type = string
}
variable "ami_name" {
  type = string
}

variable "type_vm" {
  type = string
  #validation {
  #  condition     = contains([], var.type_vm)
  #  error_message = "Incorrect vm worker type name. The variable must contain one of this values:."
  #}
}

variable "instance_profile" {
  type = string
}

variable "subnet" {
  type = string
}
variable "security_groups" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "root_volume_conf" {
  type = map(string)
}

variable "data_volumes_conf" {
  type = map(map(string))
}

variable "user_data" {
  type = string
}
variable "aws_region" {
  type        = string
  description = "The AWS region."
  default     = "us-east-1"
}

variable "instances_list" {
  type = list(
    object({
      vm_instance_type    = string
      vm_name             = string
      vm_ami_name         = string
      vm_worker_type      = string
      vm_instance_profile = string
      vm_subnet           = string
      vm_sg_list          = list(string)
      vm_tags             = map(string)
      root_volume         = map(string)
      data_volumes        = map(map(string))
    })
  )
  description = "List of variables for vm deploy."
}

variable "kms_key_id" {
  type        = string
  description = "AWS KMS key id"
}

variable "rds_config" {
  type = object({
      subnet_id  = string
      tags       = map(string)
      
  })
}
variable "product" {
  description = "Name of the product"
  type        = string
  default     = "opsview"
}

variable "domain" {
  description = "Private DomainName"
  type        = string
  default     = "eafcore.com"
}

variable "public_domain" {
  description = "Private DomainName"
  type        = string
  default     = "eaf.capgemini.com"
}

variable "env" {
  description = "Environment"
  type        = string
  default  = "development"
}

variable "tags" {
  description = "Tags to set on the resources"
  type        = map(string)
  default = {

    product   = "opsview"
    terraform = "true"
    project   = "EAF"

  }
}
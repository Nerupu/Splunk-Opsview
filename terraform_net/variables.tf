# variable "aws_region" {
#   type        = string
#   description = "The AWS region."
#   default     = "us-east-1"
# }
variable "use_ipam_pool" {
  description = "Determines whether IPAM pool is used for CIDR allocation"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to set on the resources"
  type        = map(string)
  default     = {}
}

variable "prefix" {}

variable "private_subnet_tags" {
  description = "Additional tags to be applied to private subnets"
  type        = map(string)
  default     = {}
}

variable "intra_subnet_tags" {
  description = "Additional tags to be applied to intra subnets"
  type        = map(string)
  default     = {}
}

variable "database_subnet_tags" {
  description = "Additional tags to be applied to database subnets"
  type        = map(string)
  default     = {}
}

variable "sg_tags" {
  description = "Additional tags to be applied to security"
  type        = map(string)
  default     = {}
}

variable "azs_list" {
  description = "List of SSM Iam policies"
  type        = list(string)
  default     = []
}

variable "privt_netmask" {
  description = "privt_netmask"
  type        = number
}
variable "database_netmask" {
  description = "database_netmask"
  type        = number
}
# variable "product" {
#   description = "Name of the product"
#   type        = string
#   default     = "opsview"
# }

variable "intra_netmask" {
  description = "other_netmask"
  type        = number
}

variable "private_num" {
  description = "Number of private subnets"
  type        = number
}

variable "intra_num" {
  description = "intra_num"
  type        = number
}
variable "database_num" {
  description = "database_num"
  type        = number
}
variable "security_groups" {
  type = map(object({
    name        = string
    description = string
    ingress_rules = list(object({
      description     = string
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = list(string)
      security_groups = list(string)
    }))
  }))
}
variable "egress_rules" {
  description = "A list of egress rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}


variable "ssm_policy" {
  description = "List of SSM Iam policies"
  type        = list(string)
  default     = []
}

# variable "domain" {
#   description = "Private DomainName"
#   type        = string
#   default     = "eafcore.com"
# }
variable "database_subnet_group_tags" {
  type        = map(string)
  default = {}
}
variable "domain" {
  description = "Private DomainName"
  type        = string
  default     = "eafcore.com"
}
variable "product" {
  description = "Name of the product"
  type        = string
  default     = "opsview"
}

variable "env" {
  description = "Environment"
  type        = string
  default     = "dev"
}
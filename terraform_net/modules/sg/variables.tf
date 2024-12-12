
variable "security_groups" {
  type = map(object({
    name           = string
    description    = string
    ingress_rules  = list(object({
      description      = string
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = list(string)
      security_groups  = list(string)
    }))
  }))
}
variable "egress_rules" {
  description = "A list of egress rules"
  type        = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    
  }))
}

variable "tags" {
  description = "Additional tags for the security group"
  type        = map(string)
}

variable "sg_tags" {
  description = "Tags specific to the security group"
  type        = map(string)
}

variable "vpc_id" {
  
}
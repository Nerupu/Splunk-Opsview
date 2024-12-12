# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#     }
#   }

# }
terraform {
  required_providers {
    aws = {
      version = ">= 5.0"
    }
  }

  backend "s3" {}

}


provider "aws" {
  region = var.aws_region
}
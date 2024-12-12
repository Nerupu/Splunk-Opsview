terraform {
  required_providers {
    aws = {
      version = ">= 5.0"
    }
  }

  backend "s3" {}

}

provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  alias  = "ipam"
  region = "eu-central-1"
}
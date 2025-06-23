data "aws_availability_zones" "available" {
  state = "available"
}

terraform {
  required_version = ">= 1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "local" {}
  #  backend "s3" {
  #   bucket         = "ecs-state" 
  #    key            = "ecs/terraform.tfstate"
  #    region         = "eu-central-1"
  #    encrypt        = true
  #    dynamodb_table = "ecs-state-lock" 
  #  }
}
provider "aws" {
  source = "hashicorp/aws"
  version = "6.0.0"
  region = var.aws_region
}
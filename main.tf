data "aws_availability_zones" "available" {
  state = "available"
}

terraform {
  backend "local" {}
  #  backend "s3" {
  #   bucket         = "ecs-state" 
  #    key            = "ecs/terraform.tfstate"
  #    region         = "eu-west-1"
  #    encrypt        = true
  #    dynamodb_table = "ecs-state-lock" 
  #  }
}
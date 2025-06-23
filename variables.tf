variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Name for tagging resources"
  type        = string
  default     = "sonalake-devops-ta"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "allowed_source_cidrs" {
  description = "CIDR blocks allowed to access the application"
  type        = list(string)
  default     = ["75.2.60.0/24"]
}

variable "app_container_port" {
  description = "Port on which container listens on"
  type        = number
  default     = 8080
}

variable "rds_master_username" {
  description = "Master username for the RDS PostgreSQL database"
  type        = string
  default     = "postgres"
}

variable "rds_db_name" {
  description = "Name of PostgreSQL database"
  type        = string
  default     = "app-rest"
}

variable "rds_instance_class" {
  description = "Instance type for RDS database"
  type        = string
  default     = "db.t3.micro"
}

variable "ecs_fargate_cpu" {
  description = "CPU units for ECS Fargate tasks"
  type        = number
  default     = 256
}

variable "ecs_fargate_memory" {
  description = "Memory for ECS Fargate tasks"
  type        = number
  default     = 512
}

variable "desired_ecs_tasks" {
  description = "Number of desired ECS tasks."
  type        = number
  default     = 1
}

variable "docker_image_name" {
  description = "Name of the Docker image"
  type        = string
  default     = "app-repo"
}

variable "ecr_repository_name" {
  description = "ECR repository"
  type        = string
  default     = "app-repo"
}

variable "root_domain_name" {
  description = "Domain name for application"
  type        = string
  default     = "yourdomain.com"
}
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.app.dns_name
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.app.name
}

output "rds_endpoint" {
  description = "The endpoint of the RDS PostgreSQL database"
  value       = aws_db_instance.main.address
}

output "rds_secret_arn" {
  description = "ARN of the Secrets Manager secret storing the RDS master password"
  value       = aws_secretsmanager_secret.rds_master_password.arn
}

output "alb_domain_cname" {
  description = "The full domain name assigned to the ALB"
  value       = "${var.subdomain_name}.${var.root_domain_name}"
}

output "acm_certificate_arn" {
  description = "The ARN of the validated ACM certificate"
  value       = aws_acm_certificate_validation.main.certificate_arn
}
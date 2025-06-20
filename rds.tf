resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-rds-subnet-group"
  subnet_ids = [for s in aws_subnet.private : s.id]

  tags = {
    Name = "${var.project_name}-rds-subnet-group"
  }
}

resource "aws_secretsmanager_secret" "rds_master_password" {
  name = "${var.project_name}/rds/master_password"
  tags = {
    Name = "${var.project_name}-rds-master-password"
  }
}

resource "aws_secretsmanager_secret_version" "rds_master_password_version" {
  secret_id     = aws_secretsmanager_secret.rds_master_password.id
  secret_string = random_password.rds_password.result
}

resource "random_password" "rds_password" {
  length  = 16
  special = true
  override_special = "!@#$%^&*"
  min_special = 1
}

resource "aws_db_instance" "main" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15.5" 
  instance_class       = var.rds_instance_class
  db_name              = var.rds_db_name
  username             = var.rds_master_username
  password             = random_password.rds_password.result
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot  = false
  publicly_accessible  = false
  multi_az             = false
  manage_master_user_password = true
  storage_type         = "gp2"
  final_snapshot_identifier = "${var.project_name}-final-snapshot"

  tags = {
    Name = "${var.project_name}-rds-postgres"
  }
}
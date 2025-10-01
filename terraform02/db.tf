
# RDS (PostgreSQL) Instance

resource "aws_db_instance" "strapi_rds" {
  identifier        = "manasvi-strapi-db"
  allocated_storage = 20
  engine            = "postgres"
  engine_version    = "16.3"
  instance_class    = "db.t3.micro"
  username          = var.db_username
  password          = var.db_password
  db_name           = var.db_name
  publicly_accessible = false
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnets.name
  parameter_group_name = aws_db_parameter_group.strapi_pg_params.name
  backup_retention_period = 7
  backup_window = "02:00-03:00"
  maintenance_window = "sun:04:00-sun:05:00"
  depends_on = [ aws_db_subnet_group.rds_subnets ]
}


# DB Subnet Group

resource "aws_db_subnet_group" "rds_subnets" {
  name       = "manasvi-strapi-db-subnet-group"
  subnet_ids = data.aws_subnets.default_subnets.ids
}

# Create a custom parameter group for PostgreSQL
resource "aws_db_parameter_group" "strapi_pg_params" {
  name        = "strapi-pg-params"
  family      = "postgres16" # Change to your actual RDS version family
  description = "Custom params for Strapi PostgreSQL"

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }
}

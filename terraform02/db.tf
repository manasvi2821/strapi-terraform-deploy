
# RDS (PostgreSQL) Instance

resource "aws_db_instance" "strapi_rds" {
  identifier        = "manasvi-strapi-db"
  allocated_storage = 20
  engine            = "postgres"
  engine_version    = "16"
  instance_class    = "db.t3.micro"
  username          = "strapiadmin"
  password          = "StrapiPass123!"
  db_name           = "strapidb"
  publicly_accessible = false
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnets.name
}


# DB Subnet Group

resource "aws_db_subnet_group" "rds_subnets" {
  name       = "manasvi-strapi-db-subnet-group"
  subnet_ids = data.aws_subnets.default_subnets.ids
}

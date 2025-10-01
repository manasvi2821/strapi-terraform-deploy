# Security Groups
resource "aws_security_group" "alb_sg" {
  name   = "${var.service_name}-alb-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "task_sg" {
  name   = "${var.service_name}-task-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for RDS

resource "aws_security_group" "rds_sg" {
  name   = "manasvi-strapi-rds-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    description = "Postgres access from ECS"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.task_sg.id] # Allow ECS tasks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

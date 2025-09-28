# Get default VPC and subnets
data "aws_vpc" "default" {
    default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# ECS Cluster
resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

# Logs
resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.service_name}"
  retention_in_days = 7
}

# IAM Execution Role
data "aws_iam_role" "ecs_role" {
  name = "manasvi-ecs-role"  
}

# ECS Service
resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = data.aws_subnets.default_subnets.ids
    security_groups = [aws_security_group.task_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [aws_lb_listener.http]
}


### task definition
resource "aws_ecs_task_definition" "task" {
  family                   = "${var.service_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = data.aws_iam_role.ecs_role.arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.image_url
      essential = true
      portMappings = [{
        containerPort = var.container_port
        hostPort      = var.container_port
      }]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = var.service_name
        }
      }
    }
  ])
}


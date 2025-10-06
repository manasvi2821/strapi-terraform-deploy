# ALB
resource "aws_lb" "alb" {
  name               = "${var.service_name}-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnets.default_subnets.ids
}

# resource "aws_lb_target_group" "tg" {
#   name        = "${var.service_name}-tg"
#   port        = var.container_port
#   protocol    = "HTTP"
#   vpc_id      = data.aws_vpc.default.id
#   target_type = "ip"
#   health_check {
#     path = "/admin"
#     matcher = "200"
#     interval = 30
#     timeout = 5
#     healthy_threshold = 2
#     unhealthy_threshold = 2
#   }
# }

######### blue-green target groups

resource "aws_lb_target_group" "blue" {
  name     = "${var.service_name}-blue-tg"
  port     = 1337
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}

resource "aws_lb_target_group" "green" {
  name     = "${var.service_name}-green-tg"
  port     = 1337
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id
}


resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}

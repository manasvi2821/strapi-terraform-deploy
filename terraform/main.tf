# Default VPC
data "aws_vpc" "default" {
  default = true
}

# Security Group for EC2
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
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

############################
# IAM Role & Instance Profile
############################

# Create IAM Role for EC2
# resource "aws_iam_role" "ec2_ecr_full_access_role" {
#   name = "ec2_ecr_full_access_role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect = "Allow",
#       Principal = { Service = "ec2.amazonaws.com" },
#       Action   = "sts:AssumeRole"
#     }]
#   })
# }

# # Attach AWS Managed Policies
# resource "aws_iam_role_policy_attachment" "ecr_full" {
#   role       = aws_iam_role.ec2_ecr_full_access_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
# }

# resource "aws_iam_role_policy_attachment" "ec2_full" {
#   role       = aws_iam_role.ec2_ecr_full_access_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
# }

# resource "aws_iam_role_policy_attachment" "ssm_core" {
#   role       = aws_iam_role.ec2_ecr_full_access_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
# }

# # Create Instance Profile for the Role
# resource "aws_iam_instance_profile" "ec2_ecr_full_access_profile" {
#   name = "ec2_ecr_full_access_profile"
#   role = aws_iam_role.ec2_ecr_full_access_role.name
# }

############################
# EC2 Instance
############################
resource "aws_instance" "docker_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  # iam_instance_profile   = aws_iam_instance_profile.ec2_ecr_full_access_profile.name

  tags = {
    Name = "Manasvi-strapi-server"
  }
}

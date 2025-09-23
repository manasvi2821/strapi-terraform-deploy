variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the AWS Key Pair to use for EC2"
  type        = string
  default = "manasvi-strapi-key"
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
  default     = "ami-01b6d88af12965bb6" 
}

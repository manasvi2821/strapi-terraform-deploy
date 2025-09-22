variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "public_key_path" {
  description = "Path to SSH public key"
  default     = "C:/Users/user/.ssh/id_rsa.pub"
}

variable "key_name" {
  description = "Name for AWS key pair"
  default     = "strapi-key"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "docker_image" {
  description = "Docker image to run "
  default     = "manasviii/strapi-app:latest"
}

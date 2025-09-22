variable "region" {
  description = "AWS region"
  type = string
}

variable "public_key_path" {
  type = string
}

variable "ssh_public_key" {
  description = "Public SSH key for EC2 access"
  type        = string
}

variable "instance_type" {
  default = "t2.micro"
}

variable "docker_image" {
  description = "Docker image to run "
  type = string
}

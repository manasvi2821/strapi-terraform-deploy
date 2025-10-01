variable "aws_region" {
  default = "ap-south-1"
}

variable "cluster_name" {
  default = "manasvi-strapi-cluster"
}

variable "service_name" {
  default = "manasvi-strapi-service"
}

variable "container_name" {
  default = "manasvi-strapi"
}

variable "container_port" {
  default = 1337
}

variable "image_url" {
  description = "Docker image URL (from GitHub Actions build)"
}

variable "db_name" {
  default = "manasvistrapidb"
}

variable "db_username" {
  default = "manasvidb"
}

variable "db_password" {
  default = "manasvi1234!"
}

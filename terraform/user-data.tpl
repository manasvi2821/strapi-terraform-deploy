#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user

# Login to ECR (needed on EC2 too)
$(aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${ECR_REGISTRY})

docker pull ${image}
docker run -d --name strapi -p 80:1337 ${image}

#!/bin/bash
set -e

# template vars replaced by Terraform: ${docker_image}, ${region}
DOCKER_IMAGE="${docker_image}"
REGION="${region}"

# update and install docker
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -aG docker ec2-user

# small wait for docker
sleep 5

# pull and run
docker pull "$DOCKER_IMAGE" || exit 1
docker rm -f strapi || true
docker run -d --restart unless-stopped -p 1337:1337 --name strapi "$DOCKER_IMAGE"

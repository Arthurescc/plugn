#!/bin/bash
set -euo pipefail

# Update the package repository and install required packages
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y docker.io unzip curl gh docker-compose openssh-client git

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add the 'ubuntu' user to the Docker group
sudo usermod -aG docker ubuntu

# git repo setup
eval "$(ssh-agent -s)"
sudo mkdir -p /home/ubuntu/plugn
sudo chown -R ubuntu:ubuntu /home/ubuntu/plugn
sudo mkdir -p /var/www
sudo chmod 2775 /var/www
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cd /home/ubuntu/plugn

if [ -z "${GITHUB_DEPLOY_KEY:-}" ]; then
  echo "GITHUB_DEPLOY_KEY must contain the private deploy key for git clone" >&2
  exit 1
fi

printf '%s\n' "$GITHUB_DEPLOY_KEY" > ~/.ssh/github
chmod go-rw ~/.ssh/github
ssh-keygen -y -f ~/.ssh/github > ~/.ssh/github.pub
#sudo chmod a+r ~/.ssh/github
ssh-add ~/.ssh/github
ssh-keyscan github.com >> ~/.ssh/known_hosts
git clone git@github.com:plugnio/plugn.git /home/ubuntu/plugn
#cd ./plugn
cd /home/ubuntu/plugn
git remote set-url origin git@github.com:plugnio/plugn.git
git checkout main
git config --global --add safe.directory /home/ubuntu/plugn

find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;

docker-compose -f docker-compose-prod.yml -p plugn-prod-server up -d

# Install AWS CLI
#curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
#sudo apt-get install -y unzip # Install unzip if not already available
#unzip awscliv2.zip
#sudo ./aws/install
#rm -rf awscliv2.zip aws

# Authenticate Docker to Amazon ECR
#aws ecr get-login-password --region eu-west-2 | sudo docker login --username AWS --password-stdin 438663597141.dkr.ecr.eu-west-2.amazonaws.com

# Pull the Docker image from ECR
#sudo docker pull 438663597141.dkr.ecr.eu-west-2.amazonaws.com/plugn/backend-prod

# Run the Docker container
#sudo docker run -d -p 80:80 --name plugn-backend-prod 438663597141.dkr.ecr.eu-west-2.amazonaws.com/plugn/backend-prod

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
git checkout develop
git config --global --add safe.directory /home/ubuntu/plugn

find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;

docker-compose -f docker-compose-dev.yml -p plugn-dev-server up -d

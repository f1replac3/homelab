#!/bin/bash
set -euo pipefail

echo "🔧 Installing Docker on Debian..."

# Install prerequisites
 apt update
 apt install -y ca-certificates curl gnupg lsb-release

# Add Docker’s GPG key
 install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg \
  |  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
 chmod a+r /etc/apt/keyrings/docker.gpg

# Set up Docker's repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" \
  |  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine and Compose plugin
 apt update
 apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Enable and start Docker
 systemctl enable docker
 systemctl start docker

echo "✅ Docker installed!"
docker --version
docker compose version

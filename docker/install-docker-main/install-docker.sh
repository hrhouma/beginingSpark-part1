#!/bin/bash

# Installer les prérequis pour Docker
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Ajouter la clé GPG officielle de Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Ajouter le dépôt Docker aux sources APT
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Installer Docker Engine, CLI et Containerd
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Vérifier l'installation de Docker
docker version

# (Optionnel) Ajouter l'utilisateur courant au groupe Docker pour exécuter Docker sans sudo
sudo usermod -aG docker $USER
newgrp docker

# Vérifier l'installation de Docker Compose
docker compose version

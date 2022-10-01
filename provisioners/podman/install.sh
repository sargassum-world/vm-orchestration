#!/bin/bash -eux

sudo apt-get update -y
sudo apt-get install -y podman
sudo tee -a /etc/containers/registries.conf > /dev/null <<EOT
[registries.search]
registries=["docker.io"]
EOT

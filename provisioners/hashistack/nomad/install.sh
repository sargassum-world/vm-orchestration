#!/bin/bash -eux

# Install packages
sudo apt-get update -y
sudo apt-get install -y nomad
sudo usermod -G docker -a nomad

# Prepare for configuration
mkdir -p /tmp/packer-files/hashistack/nomad/

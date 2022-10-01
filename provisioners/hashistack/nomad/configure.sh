#!/bin/bash -eux

# Copy configuration files
sudo cp /tmp/packer-files/hashistack/nomad/*.hcl /etc/nomad.d/
sudo chmod 644 /etc/nomad.d/*.hcl
sudo chown nomad:nomad /etc/nomad.d/*.hcl

# Set up plugins
sudo mkdir -p /opt/nomad/data/plugins
curl -o /tmp/packer-files/hashistack/nomad/containerd-driver https://github.com/Roblox/nomad-driver-containerd/releases/download/v0.9.3/containerd-driver
sudo cp /tmp/packer-files/hashistack/nomad/containerd-driver /opt/nomad/data/plugins/

# Set up systemd
sudo systemctl enable nomad.service
